const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();
app.use(cors());
app.use(express.json());
const db=require('./db');


// RUTAS

// Obtener todos los alumnos
app.get('/api/alumnos', (req, res) => {
    const sql = 'SELECT * FROM alumnos';
    db.query(sql, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
    });
});

// Obtener historial académico de un alumno JOIN
app.get('/api/historial/:legajo', (req, res) => {
    const { legajo } = req.params;
    const sql = `
        SELECT 
        m.nombre AS Materia,
        f.fecha AS Fecha,
        f.nota AS Nota,
        f.libro_acta AS Acta
        FROM finales f
        JOIN materias m ON f.id_materia = m.id_materia
        JOIN alumnos a ON f.id_alumno = a.id_alumno
        WHERE a.legajo = ? AND f.nota >= 4
        ORDER BY f.fecha DESC
    `;
    
    db.query(sql, [legajo], (err, data) => {
        if (err) return res.json(err);
        return res.json(data);
    });
});

// Cargar una nueva nota de cursada (POST)
app.post('/api/cursadas', (req, res) => {
    const { id_alumno, id_materia, anio, nota1, nota2, estado } = req.body;
    const sql = `
        INSERT INTO cursadas (id_alumno, id_materia, anio_cursado, nota_parcial_1, nota_parcial_2, estado)
        VALUES (?, ?, ?, ?, ?, ?)
    `;
    
    const values = [id_alumno, id_materia, anio, nota1, nota2, estado];
    
    db.query(sql, values, (err, result) => {
        if (err) return res.json(err);
        return res.json({ message: "Cursada cargada correctamente", id: result.insertId });
    });
});

app.listen(3001, () => {
    console.log("Servidor corriendo en el puerto 3030");
});