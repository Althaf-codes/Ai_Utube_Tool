const mongoose = require('mongoose');

var schema = mongoose.Schema({
    Details:{
        type:Array,
        required:true,
    },
    
})


const RepeatedUserSchema = mongoose.model('repeatedusers',schema);

module.exports =RepeatedUserSchema;