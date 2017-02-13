app.config(function ($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: 'assets/pages/diarios.html',
            controller: 'ctrlDiarios'
        })
         .when('', {
             templateUrl: 'assets/pages/diarios.html',
             controller: 'ctrlDiarios'
         })
         .when('/noticias/:idUrl', {
             templateUrl: 'assets/pages/categorias.html',
             controller: 'ctrlCategorias'
         })
         .when('/noticias/detalle/:idUrl', {
             templateUrl: 'assets/pages/noticias_detalle.html',
             controller: 'ctrlNoticias'
         })
        .otherwise({
            redirectTo: '/'
        });
});

 

