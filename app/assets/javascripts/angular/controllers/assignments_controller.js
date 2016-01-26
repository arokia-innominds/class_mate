App.factory('Assignments', ['$resource',function($resource){
  return $resource('class_rooms/:class_room_id/assignments/:assignment_id/submission.json', {},{
    submit: { method: 'POST', params: {assignment_id: '@assignment_id'} }
  })
}]);
App.factory('Submissions', ['$resource',function($resource){
  return $resource('class_rooms/:class_room_id/assignments/:assignment_id/show_submission.json', {},{
    show_submission: {method: 'GET', params: {assignment_id: '@assignment_id'}, isArray: true }
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

App.controller("SubmissionShow", ['$scope', '$http', '$resource', 'Submissions', '$location', '$routeParams', function($scope, $http, $resource, Submissions, $location, $routeParams) {
  $scope.submissions = Submissions.show_submission({assignment_id: $routeParams.id, class_room_id: $routeParams.classRoomId})
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

App.controller("Submission", ['$scope', '$resource', 'Assignments', 'Assignment', '$location','$routeParams', function($scope, $resource, Assignments, Assignment, $location, $routeParams) {
  $scope.submission = {assignment_id: $routeParams.id}
  $scope.assignment = Assignment.get({id: $routeParams.id, class_room_id: $routeParams.classRoomId});
  $scope.save = function () {
    if ($scope.assignmentForm.$valid){
      Assignments.submit({assignment_id: $routeParams.id, class_room_id: $routeParams.classRoomId},{submission: $scope.submission}, function(){
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
    $routeProvider.when('/class_rooms/:classRoomId/assignments/:id/submit', {
      templateUrl: '/templates/assignments/show.html',
      controller: "Submission"
    })
    .when('/class_rooms/:classRoomId/assignments/:id/show_submission', {
      templateUrl: '/templates/assignments/show_submission.html',
      controller: "SubmissionShow"
  });
  }
]);