const CustomerModel = require('../../models').customer;

class Customer {
  customerModel = CustomerModel.create();

  async getAllCustomersFullInfo({
    limit, skip, filters, sorts
  }) {

    return await this.customerModel.getAllCustomersFullInfo({
      limit, skip, filters, sorts
    });
  }

  async addNewCustomer({
    firstName, lastName, mobile, address,
    canWithdrawFromCash
  }) {
    await this.customerModel.addNewCustomer({
      firstName, lastName, mobile, address,
      canWithdrawFromCash
    });
  }

  async updateCustomer({
    customerId, firstName, lastName, mobile, address,
    canWithdrawFromCash
  }) {
    await this.customerModel.updateCustomer({
      customerId, firstName, lastName, mobile, address,
      canWithdrawFromCash
    });
  }

  async deleteCustomer({ customerId }) {
    await this.customerModel.deleteCustomer({ customerId });
  }

}

module.exports = {
  create: () => new Customer
};