 

app.controller('ctrlDiarios', function ($scope, $http, $window,$location) {
     $http.get("../api/noticias")
        .then(function(response) {
          console.log("response",response.data);
          $scope.noticias= response.data;
      });

      $scope.openLink=function(index){
        localStorage.news = JSON.stringify($scope.noticias[index]);
         $location.path('/noticias/'+$scope.noticias[index]["idUrl"]);
        console.log($scope.noticias[index]);
      }
});

// CATEGORIAS


app.controller('ctrlCategorias', function ($scope, $http, $window,$location,$routeParams) {
     
     $scope.new=JSON.parse(localStorage.news);

     $http.get("../api/noticias/CATEGORIAS?idUrl="+$routeParams.idUrl+"&diario=")
        .then(function(response) {
          console.log("response",response)
          $scope.categorias= response.data;
      });

      $scope.openNoticiasDetalle=function(index){
        console.log("noticias/detalle");
         localStorage.categoria = JSON.stringify($scope.categorias[index]);
         $location.path('/noticias/detalle/'+$scope.categorias[index]["idUrl"]);
         // /?idUrl='+$scope.categorias[index]["idUrl"]+"&seccion="+$scope.categorias[index]["seccion"]
        //console.log('/noticias/DETALLE?idUrl'+$scope.categorias[index]["idUrl"]+"&seccion="+$scope.categorias[index]["seccion"]);
      }


}); 


app.controller('ctrlNoticias', function ($scope, $http, $window,$location,$routeParams) {
     $scope.categoria=JSON.parse(localStorage.categoria);
     console.log("routeParams",$scope.categoria);
      var  url='../api/noticias/DETALLE?idUrl='+$scope.categoria.idUrl+"&seccion="+$scope.categoria.seccion;
     $http.get(url)
        .then(function(response) {
          console.log("response",response)
          $scope.noticias= response.data;
      });
     

}); 

app.controller('ctrlNoticiasDetalle', function ($scope, $http, $window,$location,$routeParams) {
     console.log("ctrlNoticiasDetalle -> $routeParams.id",$routeParams.id);
     /*$http.get("../api/noticias/DETALLE?idUrl="+$routeParams.id)
        .then(function(response) {
          console.log("response",response)
          $scope.categorias= response.data;
      });
      */

}); 