App.factory('Homes', ['$resource',function($resource){
  return $resource('/homes.json', {},{
    query: { method: 'GET' }
  });
}]);

App.factory('Sessions', ['$resource',function($resource){
  return $resource('users/sign_out.json', {},{
    destroy: { method: 'DELETE' }
  });
}]);

App.factory('ClassRooms', ['$resource',function($resource){
  return $resource('/class_rooms.json', {},{
    query: { method: 'GET', isArray: true },
  });
}]);

App.factory('ClassRoom', ['$resource', function($resource){
  return $resource('/class_rooms/:id.json', {}, {
    show: { method: 'GET' }
  });
}]);

App.factory('ClassRoomAssignments', ['$resource', function($resource){
  return $resource('/class_rooms/:id/assignments.json', {}, {
    assignments: { method: 'GET' , isArray: true}
  });
}]);

App.controller("ClassRoomShow", ['$scope', '$http', '$resource', 'ClassRoom', 'ClassRoomAssignments', '$location', '$routeParams', function($scope, $http, $resource, ClassRoom, ClassRoomAssignments, $location, $routeParams) {
  $scope.classroom = ClassRoom.get({id: $routeParams.id});
  $scope.assignments = ClassRoomAssignments.assignments({id: $routeParams.id});
}]);

App.controller("HomeIndex", ['$route','$scope', '$http', '$resource', 'Homes', 'Sessions', 'ClassRoomAssignments', '$location', function($route , $scope, $http, $resource, Homes, Sessions, ClassRoomAssignments, $location) {
  Homes.query().$promise.then(function(classroom) {
    $scope.assignments = ClassRoomAssignments.assignments({id: classroom.id});
    $scope.classroom = classroom
  });
  $scope.logout = function(){
    Sessions.destroy();
    $location.path( "/" );
  };
}]);


App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/class_room/:id', {
      templateUrl: '/templates/class_rooms/show.html',
      controller: "ClassRoomShow"
    })
    .when('/', {
      templateUrl: '/templates/home/index.html',
      controller: "HomeIndex"
    })
    .otherwise({
      redirectTo: '/'
    });
  }
]);