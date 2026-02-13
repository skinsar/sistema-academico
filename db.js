const mysql=require('mysql2/promise');
const connection=mysql.createPool({
    host:"localhost",
    user:"root",
    password:"8319.Gabriel.",
    database:"sistema_academico"
});

connection.connect(err=>{
    if (err){
        console.error('error al conectar la base de datos',err);
        return;
    }
    console.log('MyQSL conectado exitosamente');
});