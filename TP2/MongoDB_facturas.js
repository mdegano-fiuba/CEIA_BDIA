// 1. Realizar una consulta que devuelva la siguiente información: Región y cantidad total de productos vendidos a clientes de esa Región.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$cliente.region",
      total: {
        $sum: "$item.cantidad"
      }
    }
  },
  {
    $project: {
      region: "$_id",
      total: 1,
      _id: 0
    }
  }
])

// 2. Basado en la consulta del punto 1, mostrar sólo la región que tenga el menor ingreso.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$cliente.region",
      total: {
        $sum: "$item.cantidad"
      }
    }
  },
  {
    $project: {
      region: "$_id",
      total: 1,
      _id: 0
    }
  },{
    $sort: {
      total: 1
    }
  },{
    $limit: 1
  }
])

// 3. Basado en la consulta del punto 1, mostrar sólo las regiones que tengan una cantidad de productos vendidos superior a 10000.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$cliente.region",
      total: {
        $sum: "$item.cantidad"
      }
    }
  },
  {
    $project: {
      region: "$_id",
      total: 1,
      _id: 0
    }
  },{
    $match:{
      total: {
      	$gt: 10000
      }
    }
  }
])

// Superior a 300

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$cliente.region",
      total: {
        $sum: "$item.cantidad"
      }
    }
  },
  {
    $project: {
      region: "$_id",
      total: 1,
      _id: 0
    }
  },{
    $match:{
      total: {
      	$gt: 300
      }
    }
  }
])

// 4. Se requiere obtener un reporte que contenga la siguiente información, nro. cuit, apellido y nombre y región y cantidad de facturas, ordenado por apellido.

db.facturas.aggregate([
  {
    $group: {
      _id: {
        apellido: "$cliente.apellido",
        nombre: "$cliente.nombre",
        region: "$cliente.region",
        cuit: "$cliente.cuit"
      },
      cantFacturas:{
        $sum: 1
      }
    }
  },
  {
    $project: {
      apellido: "$_id.apellido",
      nombre: "$_id.nombre",
      region: "$_id.region",
      cuit: "$_id.cuit",
      cantFacturas: 1,
      _id: 0
    }
  },
  {
    $sort: {
      apellido: 1
    }
  }
])

// 5. Basados en la consulta del punto 4 informar sólo los clientes con número de CUIT mayor a 27000000000.

db.facturas.aggregate([
  {
    $group: {
      _id: {
        apellido: "$cliente.apellido",
        nombre: "$cliente.nombre",
        region: "$cliente.region",
        cuit: "$cliente.cuit"
      },
      cantFacturas: {
        $sum: 1
      }
    }
  },
  {
    $project: {
      apellido: "$_id.apellido",
      nombre: "$_id.nombre",
      region: "$_id.region",
      cuit: "$_id.cuit",
      cantFacturas: 1,
      _id: 0
    }
  },
  {
    $match: {
      cuit: { 
        $gt: 27000000000 
      }
    }
  },
  {
    $sort: {
      apellido: 1
    }
  }
])

// CUIT mayor a 2700000000

db.facturas.aggregate([
  {
    $group: {
      _id: {
        apellido: "$cliente.apellido",
        nombre: "$cliente.nombre",
        region: "$cliente.region",
        cuit: "$cliente.cuit"
      },
      cantFacturas: {
        $sum: 1
      }
    }
  },
  {
    $project: {
      apellido: "$_id.apellido",
      nombre: "$_id.nombre",
      region: "$_id.region",
      cuit: "$_id.cuit",
      cantFacturas: 1,
      _id: 0
    }
  },
  {
    $match: {
      cuit: { 
        $gt: 2700000000
      }
    }
  },
  {
    $sort: {
      apellido: 1
    }
  }
])


// 6. Basados en la consulta del punto 5 informar solamente la cantidad de clientes que cumplen con esta condición.

db.facturas.aggregate([
  {
    $group: {
      _id: {
        apellido: "$cliente.apellido",
        nombre: "$cliente.nombre",
        region: "$cliente.region",
        cuit: "$cliente.cuit"
      },
      cantFacturas: {
        $sum: 1
      }
    }
  },
  {
    $project: {
      apellido: "$_id.apellido",
      nombre: "$_id.nombre",
      region: "$_id.region",
      cuit: "$_id.cuit",
      cantFacturas: 1,
      _id: 0
    }
  },
  {
    $match: {
      cuit: { 
        $gt: 2700000000
      }
    }
  },
  {
    $count: "totalClientes"
  }
])

// 7. Se requiere realizar una consulta que devuelva la siguiente información: producto y cantidad de facturas en las que lo compraron, ordenado por cantidad de facturas descendente.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: {
        producto: "$item.producto",
        factura: "$nroFactura"
      }
    }
  },
  {
    $group: {
      _id: "$_id.producto",
      cantFacturas: { 
        $sum: 1 
      }
    }
  },
  {
    $project: {
      producto: "$_id",
      cantFacturas: 1,
      _id: 0
    }
  },
  {
    $sort: {
      cantFacturas: -1
    }
  }
])

// 8. Obtener la cantidad total comprada así como también los ingresos totales para cada producto.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$item.producto",
      totalCantidad: {
        $sum: "$item.cantidad" 
      }, 
      totalIngresos: { 
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        } 
      }
    }
  },
  {
    $project: {
      producto: "$_id", 
      totalCantidad: 1,
      totalIngresos: 1,
      _id: 0
    }
  },
  {
    $sort: {
      totalIngresos: -1
    }
  }
])

// 9. Idem el punto anterior, ordenar por ingresos en forma ascendente, saltear el 1ro y mostrar 2do y 3ro.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$item.producto",
      totalCantidad: {
        $sum: "$item.cantidad" 
      }, 
      totalIngresos: { 
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        } 
      }
    }
  },
  {
    $project: {
      producto: "$_id", 
      totalCantidad: 1,
      totalIngresos: 1,
      _id: 0
    }
  },
  {
    $sort: {
      totalIngresos: 1
    }
  },
  {
    $skip: 1
  },
  {
    $limit: 2
  }
])

// 10. Obtener todos productos junto con un array de las personas que lo compraron. 
// En este array deberá haber solo strings con el nombre completo de la persona. 
// Los documentos entregados como resultado deberán tener la siguiente forma:
// {producto: “<nombre>”, personas:[“…”, …]}


db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$item.producto",
      personas: {
        $addToSet: {
          $concat: [
            "$cliente.nombre", " ", "$cliente.apellido"
          ]
        }
      }
    }
  },
  {
    $project: {
      producto: "$_id",
      personas: 1,
      _id: 0
    }
  }
])

// 11. Obtener los productos ordenados en forma descendente por la cantidad de diferentes personas que los compraron.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: {
        producto: "$item.producto",
        persona: {
          $concat: ["$cliente.nombre", " ", "$cliente.apellido"]
        }
      }
    }
  },
  {
    $group: {
      _id: "$_id.producto",
      cantidadPersonas: { $sum: 1 }
    }
  },
  {
    $project: {
      producto: "$_id",
      cantidadPersonas: 1,
      _id: 0
    }
  },
  {
    $sort: {
      cantidadPersonas: -1
    }
  }
])

// 12. Obtener el total gastado por persona y mostrar solo los que gastaron más de 3100000. 
// Los documentos devueltos deben tener el nombre completo del cliente y el total gastado:
// {cliente:”<nombreCompleto>”,total:<num>}

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: {
        nombreCompleto: { 
          $concat: ["$cliente.nombre", " ", "$cliente.apellido"] 
        }
      },
      totalGastado: {
        $sum: { $multiply: ["$item.cantidad", "$item.precio"] }
      }
    }
  },
  {
    $match: {
      totalGastado: { 
        $gt: 3100000
      }
    }
  },
  {
    $project: {
      cliente: "$_id.nombreCompleto",
      total: "$totalGastado",
      _id: 0
    }
  }
])

// Gastaron más de 31000

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: {
        nombreCompleto: { 
          $concat: ["$cliente.nombre", " ", "$cliente.apellido"] 
        }
      },
      totalGastado: {
        $sum: { $multiply: ["$item.cantidad", "$item.precio"] }
      }
    }
  },
  {
    $match: {
      totalGastado: { 
        $gt: 31000
      }
    }
  },
  {
    $project: {
      cliente: "$_id.nombreCompleto",
      total: "$totalGastado",
      _id: 0
    }
  }
])

// 13. Obtener el promedio de gasto por factura por cada región.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$_id",
      region: { 
        $first: "$cliente.region" 
      },
      totalFactura: {
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        }
      }
    }
  },
  {
    $group: {
      _id: "$region",
      totalGastado: { 
        $sum: "$totalFactura" 
      },
      cantidadFacturas: { 
        $sum: 1 
      }
    }
  },
  {
    $project: {
      region: "$_id",
      promedioPorFactura: {
        $divide: ["$totalGastado", "$cantidadFacturas"]
      },
      _id: 0
    }
  }
])

// 14. Obtener la factura en la que se haya gastado más. 
// En caso de que sean varias obtener la que tenga el número de factura menor.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$_id",
      nroFactura: { 
        $first: "$nroFactura" 
      },
      cliente: { 
        $first: "$cliente" 
      },
      totalFactura: {
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        }
      }
    }
  },
  {
    $sort: {
      totalFactura: -1,
      nroFactura: 1
    }
  },
  {
    $limit: 1
  },
  {
    $project: {
      _id: 0,
      nroFactura: 1,
      cliente: {
        nombreCompleto: {
          $concat: ["$cliente.nombre", " ", "$cliente.apellido"]
        },
        region: "$cliente.region"
      },
      totalFactura: 1
    }
  }
])

// 15. Obtener a los clientes indicando cuánto fue lo que más gastó en una única factura.

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: {
        clienteId: "$cliente.cuit",
        nombreCompleto: {
          $concat: ["$cliente.nombre", " ", "$cliente.apellido"]
        },
        facturaId: "$_id"
      },
      totalFactura: {
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        }
      }
    }
  },
  {
    $group: {
      _id: {
        clienteId: "$_id.clienteId",
        nombreCompleto: "$_id.nombreCompleto"
      },
      gastoMaximo: { 
        $max: "$totalFactura" 
      }
    }
  },
  {
    $project: {
      _id: 0,
      cliente: "$_id.nombreCompleto",
      gastoMaximo: 1
    }
  }
])

// 16. Utilizando MapReduce, indicar la cantidad total comprada de cada ítem. 
// Comparar el resultado con el ejercicio 8.

var mapFunction = function () {
  this.item.forEach(function (producto) {
    emit(producto.producto, producto.cantidad);
  });
};

var reduceFunction = function (key, values) {
  return Array.sum(values);
};

db.facturas.mapReduce(
  mapFunction,
  reduceFunction,
  {
    out: "total_por_producto"
  }
);

db.total_por_producto.find().sort({ value: -1 })


// https://docs.mongodb.com/manual/core/map-reduce
// Starting in MongoDB 5.0, map-reduce is deprecated
// Aggregation Pipeline as Alternative

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$item.producto",
      cantidadTotal: { 
        $sum: "$item.cantidad" 
      } 
    }
  },
  {
    $project: {
      producto: "$_id",
      cantidadTotal: 1,
      _id: 0
    }
  },
  {
    $sort: {
      cantidadTotal: -1
    }
  }
])

// 17. Obtener la información de los clientes que hayan gastado 100000 en una orden junto con el número de orden.
// Asumo Orden = Factura, Total gastado iual a 1960

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$_id",  
      nroFactura: { 
        $first: "$nroFactura" 
      },
      cliente: {
        $first: {
          $concat: ["$cliente.nombre", " ", "$cliente.apellido"]
        }
      },
      totalGastado: {
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        }
      }
    }
  },
  {
    $match: {
      totalGastado: 1960
    }
  },
  {
    $project: {
      _id: 0,
      cliente: 1,
      nroFactura: 1,
      totalGastado: 1
    }
  }
])

// 18. En base a la localidad de los clientes, obtener el total facturado por localidad.
// Asumo Localidad = Región

db.facturas.aggregate([
  {
    $unwind: "$item"
  },
  {
    $group: {
      _id: "$cliente.region",
      totalFacturado: {
        $sum: { 
          $multiply: ["$item.cantidad", "$item.precio"] 
        }
      }
    }
  },
  {
    $project: {
      _id: 0,
      region: "$_id",
      totalFacturado: 1
    }
  },
  {
    $sort: {
      totalFacturado: -1
    }
  }
])

