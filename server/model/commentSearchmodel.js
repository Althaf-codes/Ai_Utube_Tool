const mongoose = require('mongoose');

var schema = mongoose.Schema({
    Sentence:{
        type:Array,
        required:true,
        
    },
    results:{
            type:Array,
            required:true
        }
        // {
        //     "result":{
        //         type:Array,
        //         required:true
        //     }
        // }
    
})


const YtSchema = mongoose.model('commentSearch',schema);

module.exports = YtSchema;