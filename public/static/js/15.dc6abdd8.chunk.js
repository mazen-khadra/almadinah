(this.webpackJsonpal_madinah=this.webpackJsonpal_madinah||[]).push([[15],{941:function(e,n,t){"use strict";t.r(n);var o=t(70),r=t(0),a=t(931),i=t(710),c=t(781),s=t(705),l=t(190),u=t(709),d=t(700),j=t(75),b=t(152),g=t(930),h=t(1),f=Object(d.a)()(Object(j.b)((function(e){var n=e.forgot;return{error:n.error,loading:n.loading}}),{forgotInfoChanged:b.c,postForgotPassword:b.e})((function(e){var n=e.t,t=e.onClose,i=e.visible,c=e.loading,l=e.error,u=e.forgotInfoChanged,d=e.postForgotPassword,j=Object(r.useState)(""),b=Object(o.a)(j,2),f=b[0],O=b[1],p=function(e){return u({props:"error",value:e})};return Object(h.jsxs)(g.a,{open:i,size:"tiny",onClose:t,centered:!0,closeOnEscape:!0,closeIcon:!0,children:[Object(h.jsx)(g.a.Header,{children:n("ForgotPassword")}),Object(h.jsx)(g.a.Content,{children:Object(h.jsxs)(g.a.Description,{children:[function(){if(l)return Object(h.jsx)(a.a,{negative:!0,icon:"x",header:n("Error"),content:l})}(),Object(h.jsxs)(s.a,{loading:c,children:[Object(h.jsx)(s.a.Input,{fluid:!0,type:"text",label:n("UserName"),placeholder:"example123",required:!0,icon:"mail",size:"huge",maxLength:50,iconPosition:"left",value:f,onChange:function(e,n){var t=n.value;return O(t.toLowerCase())},onFocus:function(){return p("")},autoFocus:!0}),Object(h.jsx)(s.a.Button,{color:"green",fluid:!0,onClick:function(){f&&(p(""),1)&&d(f,t)},children:n("Send")})]})]})})]})})));n.default=Object(d.a)()(Object(j.b)((function(e){var n=e.auth;return{loading:n.loading,error:n.error}}),{signinInfoChanged:b.i,signin:b.h})((function(e){var n=e.t,t=e.signinInfoChanged,d=e.loading,j=e.error,b=e.signin,g=Object(r.useState)(""),O=Object(o.a)(g,2),p=O[0],x=O[1],v=Object(r.useState)(""),C=Object(o.a)(v,2),m=C[0],w=C[1],y=Object(r.useState)(!1),I=Object(o.a)(y,2),k=I[0],F=I[1],P=Object(r.useState)(!1),S=Object(o.a)(P,2),L=S[0],z=S[1],q=function(){return t({props:"error",value:""})};return Object(h.jsxs)(i.a,{basic:!0,children:[Object(h.jsx)(c.a,{style:{width:"50vw",padding:20},children:Object(h.jsxs)(i.a,{style:{backgroundColor:"rgba(122, 123, 32, 0.3)"},children:[function(){if(j)return Object(h.jsx)(a.a,{negative:!0,icon:"x",header:n("Error"),content:j})}(),Object(h.jsxs)(s.a,{loading:d,children:[Object(h.jsx)(s.a.Input,{fluid:!0,type:"text",label:n("UserName"),placeholder:"example123",required:!0,icon:"mail",size:"huge",maxLength:50,iconPosition:"left",value:p,onChange:function(e,n){var t=n.value;return x(t.toLowerCase())},onFocus:q}),Object(h.jsx)(s.a.Input,{fluid:!0,type:L?"text":"password",label:n("Password"),placeholder:"*********",required:!0,icon:Object(h.jsx)(l.a,{name:L?"eye":"eye slash",link:!0,onClick:function(){return z(!L)}}),size:"huge",maxLength:20,minLength:3,iconPosition:"left",value:m,onChange:function(e,n){var t=n.value;return w(t)},onFocus:q,autoComplete:"on"}),Object(h.jsx)(u.a,{style:{cursor:"pointer",textAlign:"center"},color:"blue",as:"h5",onClick:function(){return F(!0)},children:n("ForgotPassword")}),Object(h.jsx)(s.a.Button,{color:"green",fluid:!0,onClick:function(){p&&m&&(q(),1)&&b(p,m)},children:n("SignIn").toUpperCase()})]})]})}),Object(h.jsx)(f,{visible:k,onClose:function(){return F(!1)}})]})})))}}]);
//# sourceMappingURL=15.dc6abdd8.chunk.js.map