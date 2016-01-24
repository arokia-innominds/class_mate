App.factory('Assignments', ['$resource',function($resource){
  return $resource('class_rooms/:class_room_id/assignments.json', {},{
    query: { method: 'GET', isArray: true },
    create: { method: 'POST', params: {class_room_id: '@class_room_id'} }
  })
}]);

App.factory('Assignment', ['$resource', function($resource){
  return $resource('class_rooms/:class_room_id/assignments/:id.json', {}, {
    show: { method: 'GET' },
    update: { method: 'PUT', params: {id: '@id'} },
    delete: { method: 'DELETE', params: {id: '@id', class_room_id: '@class_room_id'} }
  });
}]);

App.controller("AssignmentShow", ['$scope', '$http', '$resource', 'ClassRoom', 'ClassRoomAssignments', '$location', '$routeParams', function($scope, $http, $resource, ClassRoom, ClassRoomAssignments, $location, $routeParams) {
  $scope.assignment = Assignment.get({id: $routeParams.id, class_room_id: $routeParams.classRoomId})
}]);

App.controller("AssignmentsList", ['$scope', '$http', '$resource', 'Assignments', 'Assignment', '$location','$routeParams', function($scope, $http, $resource, Assignments, Assignment, $location,$routeParams) {

  $scope.assignments = Assignments.query();

  $scope.deleteAssignment = function (assignmentId) {
    if (confirm("Are you sure you want to delete this user?")){
      Assignment.delete({ id: assignmentId,  class_room_id: $routeParams.classRoomId}, function(){
        $scope.assignments = Assignments.query();
        $location.path('/');
      });
    }
  };
}]);

App.controller("AddAssignment", ['$scope', '$resource', 'Assignments', '$location','$routeParams', function($scope, $resource, Assignments, $location, $routeParams) {
  $scope.assignment = {}
  $scope.save = function () {
    if ($scope.assignmentForm.$valid){
      Assignments.create({class_room_id: $routeParams.classRoomId},{assignment: $scope.assignment}, function(){
        $location.path('/');
      }, function(error){
        console.log(error)
      });
    }
  }
}]);

App.controller("AssignmentUpdate", ['$scope', '$resource', 'Assignments', 'Assignment' , '$location', '$routeParams', function($scope, $resource, Assignments, Assignment, $location, $routeParams) {
  $scope.assignment = Assignment.get({id: $routeParams.id, class_room_id: $routeParams.classRoomId})
  $scope.update = function () {
    if ($scope.assignmentForm.$valid){
      Assignment.update({id: $scope.assignment.id, class_room_id: $routeParams.classRoomId},{assignment: $scope.assignment},function(){
        $location.path('/');
      }, function(error) {
        console.log(error)
      });
    }
  }
}]);

App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/class_rooms/:classRoomId/assignments',{
      templateUrl: '/templates/assignments/index.html',
      controller: 'AssignmentsList'
    });
    $routeProvider.when('/class_rooms/:classRoomId/assignments/new', {
      templateUrl: '/templates/assignments/new.html',
      controller: 'AddAssignment'
    });
    $routeProvider.when('/class_rooms/:classRoomId/assignments/:id/edit', {
      templateUrl: '/templates/assignments/edit.html',
      controller: "AssignmentUpdate"
    });
    $routeProvider.when('/class_rooms/:classRoomId/assignments/:id', {
      templateUrl: '/templates/assignments/show.html',
      controller: "AssignmentUpdate"
    });
  }
]);