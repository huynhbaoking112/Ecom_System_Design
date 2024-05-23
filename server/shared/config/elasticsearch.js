const elasticsearch = require("elasticsearch");



const allElastic = {}

const connectElastic = ()=>{
  const client = new elasticsearch.Client({
    host: ["https://elastic:xVZ2_eO**RHdL5Z499xD@localhost:9200"],
  })

  //CheckConnect
  client.ping({
    requestTimeout: 30000
  },(err)=>{
    if(err){
      console.log("Elasticsearch cluster is down!");
    }else{
      console.log('Success connect to Elasticsearch!');
      allElastic.productElastic = client
    }
  })

}


const getElastic = ()=>{
  return allElastic
}


module.exports = {
  connectElastic,
  getElastic
}