require('@tensorflow/tfjs');
const toxicity = require('@tensorflow-models/toxicity');
const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const connectDB = require('./Database/data');
const YtSchema = require('./model/commentSearchmodel');
const RepeatedUserSchema = require('./model/repeatedUsermodel');
const threshold = 0.6;
const port = process.env.PORT || 8080;
var funResult = [];

dotenv.config({path:'./server/config.env'});


async function runServer() {
    const model = await toxicity.load(threshold);
    const app = express();
    const router = express.Router();
    app.use(express.urlencoded({extended:true})); 
    app.use(express.json());
   
  app.use(
    cors({
        origin:"*",
       // origin:"http://localhost:61324",
    })
  )
connectDB();

// let PostSentence=(sentence,result)=>{
//   const ClassifiedVal =new YtSchema({
//       Sentence:req.body.Sentence,
//       results:result
//   })

//   ClassifiedVal.save(ClassifiedVal).then((data)=>{
//       console.log('data saved');
//       console.log(data);
//   })
// }

app.get('/api/:reqsentence',(req,res)=>{
    let sentence =req.params.reqsentence
        // toxicity.load(threshold).then(model=>{
            model.classify([sentence]).then(predictions=>{
                var i = 0;
                while(i<7){
                    var label = predictions[i].label;
                    var result  = predictions[i].results[0].match;
                  
                   funResult[i]={
                        label:label,
                        result:result
                    
                   }
                    i++;
                  }
                  console.log(funResult);
                  console.log('fun result is ');
                   var filterResult = funResult.filter(function(el){
                    return el.result=== true || el.result == null
                   })
                   var finalLabel = filterResult.filter(function(el){
                    return el.label
                })

                var finalresult = filterResult.filter(function(el){
                  return el.result
              })        
              
            //  let dataresult=()=>{
            //  while(i<filterResult.length){
            //    var ClassifiedVal =new YtSchema({
            //      Sentence:sentence.toString(),
            //      results:[{
            //        label:finalLabel[i],
            //        result: finalresult[i]
            //      }]
            //    })
            //    i++;
            //  }
            //  console.log('schema value is');
            //  console.log(ClassifiedVal);
            //  return ClassifiedVal;
            //  }
             
               //let lastResult =console.log(funResult);
                console.log('it is here happening');
                console.log();
                console.log(filterResult);
                
                const ClassifiedVal =new YtSchema({
                  Sentence:sentence.toString(),
                  results:finalLabel  
                })
              ClassifiedVal.save(ClassifiedVal).then((data)=>{
                  console.log('data saved')
                  console.log(data);
                  res.status(200).send(filterResult);
                })

                   
        })
      // })
    }
      )

      app.get('/api/values/:manySentences',(req,res)=>{
        const sentenceArray = [req.params.manySentences];
        const strSentence = String(sentenceArray);
        var singleSentence = strSentence.split(',');
        console.log(singleSentence);

        let arrLen = singleSentence.length;
        var j =0;
        var allResult = [];
        var testResult=
        [
          [
            {
              "label": "insult",
              "result": true
            },
            {
              "label": "toxicity",
              "result": true
            }
          ],
          [
            {
              "label": "insult",
              "result": true
            },
            {
              "label": "obscene",
              "result": null
            },
            {
              "label": "sexual_explicit",
              "result": null
            },
            {
              "label": "toxicity",
              "result": true
            }
          ],
          [
            {
              "label": "threat",
              "result": null
            },
            {
              "label": "toxicity",
              "result": null
            }
          ]
        ]
        
 let Toxicity = async (sentence)=>{
  // toxicity.load(threshold).then(model=>{

      model.classify([sentence]).then(predictions=>{
       
          var i = 0;
          while(i<7){
            
              var label = predictions[i].label;
              var result  = predictions[i].results[0].match;
            
             funResult[i]={
                  label:label,
                  result:result
              
              }
              i++;
              
             }
          //    console.log('funResult is :');
          //    console.log(funResult);
             var filterResult = funResult.filter(function(el){
              return el.result=== true || el.result == null

            })
            console.log(`filterResult of ${j} is :`);
            console.log(filterResult);
          //   for(i=0;i<filterResult.length;i++){
          //      var finlabel= filterResult[i].label;
          //     //  console.log('finLabel is:');
          //     //  console.log(finlabel);
          //   }
          var finalLabel = filterResult.filter(function(el){
              return el.label
          })

          console.log("finalLabel is :");
          console.log(finalLabel);
          allResult.push(
              finalLabel)
          //       const filters = [true ]  
      //       var records = filters.map((boolVal) => {
      //         return funResult.filter((item) => item.result === boolVal)
      //       })
      //    let lastResult = console.log(records);
      // console.log("finalLabel is:");
      // console.log(finalLabel);
      // console.log('printing last result:');
      
      //PostSentence(sentence,filterResult)
      if(j<arrLen){
          if(j+1==arrLen){
              console.log('all result is');
              console.log(allResult);
              const ClassifiedVal =new YtSchema({
                Sentence:singleSentence,
                results:allResult 
              })
            ClassifiedVal.save(ClassifiedVal).then((data)=>{
                console.log('data saved')
                console.log(data);
             //   res.status(200).send(filterResult);
                res.status(200).send(allResult);
              })
              return;
          }else{
             
              
      Toxicity(singleSentence[j+1]);

  }
      j++;
   }

      var lastResult = console.log(filterResult);
      return lastResult;
  }).catch(err=>{console.log(err)});
// })
}

Toxicity(singleSentence[0]);
//res.status(200).send(testResult);

      })

      app.post('/api/repeated/user',(req,res)=>{
        if(!req.body){
          res.status(400).send({message:"Fill the details"});
          return;
      };
        console.log('api called');
        const sentenceArray = req.body.Details;

        const RepeatedUsers = new RepeatedUserSchema({
          Details:sentenceArray
        });

        RepeatedUsers.save(RepeatedUsers).then((data)=>{

          console.log('Repeated data saved');
          console.log(data);
          res.status(200).send('Data Saved')
        }).catch((err)=>{
          res.status(500).send({
          message:err.message||"Some error occurred while creating a create operation "
          }); 
      })
        
      });

      app.get('/api/getRepeated/users',(req,res)=>{
    
        const id =req.query.id;
        const user = RepeatedUserSchema;
    
        if(req.query.id){
            user.findById(id).then((data)=>{
              if(!data){
                  res.status(404).send({message:"User not found with id ="+id});
              }else{
                  res.send(data);
                  console.log("Single user Data retrieved");
              }
            }).catch((err)=>{
                res.status(500).send({message:err.message||"Error retrieving user with id="+id});
            })
        }else{
    
            user.find().then(user=>{
              var repNameArr = [];
              var repImgArr = [];
              var repTcArr = [];
              const count=[];
              const result = [];
              var i=0;
              var j=0;
              for(i=0;i<user.length;i++){
                for(j=0;j<user[i].Details.length;j++){
                  var repName = user[i].Details[j].name;
                  var repImg  = user[i].Details[j].img;
                  var repTc = user[i].Details[j].tc;
                  
                  repNameArr.push(repName);
                  repImgArr.push(repImg);
                  repTcArr.push(repTc);


                }
              }
              
              for(i=0;i<repNameArr.length;i++){
                for(j=i+1;j<repNameArr.length;j++){
                  if(repNameArr[i]==repNameArr[j]){
                    console.log(repNameArr[j]);
                  }
                }
              }
          
                res.status(200).send(user);
                console.log("Data Found");
            }).catch(err=>{
                res.status(500).send({message:err.message||"Error occured while retrieving user information"});
            })
        }
      })
      
      app.delete('/api/delete/user',(req,res)=>{
        const user = RepeatedUserSchema;

        user.remove().then((data)=>{
          res.status(200).send("ALL Data deleted");
          console.log('Deleted');
        }).catch(err=>{
          res.status(500).send({message:err.message||"Error occured while deleting"});
        }
          )
      })

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
  });

    }

runServer();