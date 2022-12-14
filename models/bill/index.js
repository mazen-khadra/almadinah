const Model = require('../model');
billRecordModel = require('./records');

class Bill extends Model {
 
  records = billRecordModel.create();

  async getAllBillsFullInfo ({
    limit, skip, filters, sorts
  }) {
    let countQuery =
      `SELECT
        COUNT(*) allCount
      FROM
        bills;`

    let dataQuery =
      `SELECT
        id_bill billId,
        customer_id customerId,
        b.serial_number serialNumber,
        notic,
        b.at,
        final_total finalTotal
      FROM
        bills b`;

    let queryStr = `${countQuery + dataQuery}`;
        
    queryStr = this.applyFilters( dataQuery, filters ) || queryStr;
    queryStr += `${this.getOrderClause(sorts)}`;
    queryStr += `${this.getLimitClause({ limit, skip })};`;


    let dbRet = await this.directQuery(queryStr);

    return {
      allCount: dbRet[0][0].allCount,
      data: dbRet[1]
    };

  }
  
  async getBillDetails ({billId}) {
    let queryStr = 'CALL prc_get_bill_details(?);'

    let dbRet = await this.directQuery(queryStr, billId);
    let data = null;

    if(dbRet[0] && dbRet[0][0]) {
      data = dbRet[0][0];
      data.records = dbRet[1];
    }

    return { data };
  }

  async addBill ({
    customerId, notic, serialNumber, at,
    finalTotal, records 
    /*[{quantity, unitPrice, discount, addition, notice}]*/
  }) {
    
    let queryStr = `CALL prc_add_bill(?, @new_entry_id);`    
    let dbRet = await this.directQuery (
      queryStr, 
      [customerId, serialNumber, notic, at, finalTotal]
    );

    let newId = dbRet[0][0].newRecordId;

    await this.records.resetBillRecords({
      billId: newId, records
    });

    return {newId};
  }

  async updateBill ({
    billId, customerId, notic, serialNumber, at,
    finalTotal, records 
    /*[{quantity, unitPrice, discount, addition, notice}]*/
  }) {
    await this.directQuery (
      'CALL prc_update_bill(?);',
       [billId, customerId, serialNumber, notic, at, finalTotal]
    );

    await this.records.resetBillRecords({billId, records});
  }

  async deleteBill ({billId}) {
    await this.directQuery (
      'CALL prc_delete_bill(?);',
      billId
    );
  }

}

module.exports = {
  create: () => new Bill
};
