const nodemailer = require('nodemailer');
const Dev = require('../../../shared/models/dev_model');
const ErrorMod = require('../../../shared/models/log_error.model');




const NotiOfDev = async(message)=>{

    //Get infor-dev
    const allDev = await Dev.find()

    //Get email-dev
    const emailOfDev = allDev.map((e) => e.email)


    //gui  email
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: process.env.email,
          pass: process.env.password
        }
      })
      const mailOptions = {
        from: 'TechShop <TechShopOfPtit>',
        to:  emailOfDev,
        subject: 'Error of TechShop', 
        text: message
      };
  
      transporter.sendMail(mailOptions, async (error, info) => {
        if (error) {
            await ErrorMod.create("Email send error to dev notworking!")
        } else {
          console.log('Email sent success');
        }
      });
  

}


module.exports = {NotiOfDev}

