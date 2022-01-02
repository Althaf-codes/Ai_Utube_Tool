const YtSchema = require('../model/commentSearchmodel');

exports.create = (req,res)=>{

    if(!req.body){
        res.status(400).send({message:"Fill the details"});
        return;
    }

    const ClassifiedVal =new YtSchema({
        Sentence:req.body.Sentence,
        results:[{label:req.body}]
    })

    user.save(user).then((data)=>{
        res.status(201).send(data);
        console.log("data saved");
    }).catch((err)=>{
        res.status(500).send({
        message:err.message||"Some error occurred while creating a create operation "
        }); 
    })
}