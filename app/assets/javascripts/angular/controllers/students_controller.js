App.factory('Students', ['$resource',function($resource){
  return $resource('/students.json', {},{
    query: { method: 'GET', isArray: true },
    create: { method: 'POST' }
  })
}]);

App.factory('Student', ['$resource', function($resource){
  return $resource('/students/:id.json', {}, {
    show: { method: 'GET' },
    update: { method: 'PUT', params: {id: '@id'} },
    delete: { method: 'DELETE', params: {id: '@id'} }
  });
}]);

App.controller("StudentShow", ['$scope', '$http', '$resource', 'Student', '$location', '$routeParams', function($scope, $http, $resource, Student, $location, $routeParams) {
  $scope.classroom = Student.get({id: $routeParams.id});
}]);

App.controller("AddStudent", ['$scope', '$resource', 'Students', '$location', function($scope, $resource, Students, $location) {
  $scope.student = {}
  $scope.save = function () {
    if ($scope.studentForm.$valid){
      Students.create({student: $scope.student}, function(){
        $location.path('/students');
      }, function(error){
        console.log(error)
      });
    }
  }
}]);

App.controller("StudentUpdate", ['$scope', '$resource', 'Student', '$location', '$routeParams', function($scope, $resource, Student, $location, $routeParams) {
  $scope.student = Student.get({id: $routeParams.id})
  $scope.update = function () {
    if ($scope.studentForm.$valid){
      Student.update({id: $scope.student.id},{student: $scope.student},function(){
        $location.path('/');
      }, function(error) {
        console.log(error)
      });
    }
  }
}]);

App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/students',{
      templateUrl: '/templates/students/index.html',
      controller: 'StudentsList'
    });
    $routeProvider.when('/students/new', {
      templateUrl: '/templates/students/new.html',
      controller: 'AddStudent'
    });
    $routeProvider.when('/students/:id/edit', {
      templateUrl: '/templates/students/edit.html',
      controller: "StudentUpdate"
    });
    $routeProvider.when('/students/:id', {
      templateUrl: '/templates/students/show.html',
      controller: "StudentShow"
    });
    $routeProvider.otherwise({
      redirectTo: '/students'
    });
  }
]);