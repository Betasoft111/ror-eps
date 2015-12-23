/*
 * Intialize The Join Application
 */

var app = angular.module('joinApp', ['ngPasswordStrength']);

/*
 * Intialize The Controller
 */
app.controller('joinController', function($scope, $timeout) {

  /*
   * Set the submit button value
   */
  $scope.disabledJoin = true;

  $scope.$watch('user.password', function(newVal, oldVal) {
    if (newVal !== oldVal) {
      $timeout(function() {
        var style = $(".progress-bar").width() / $('.progress-bar').parent().width() * 100;
        //console.log('style is ', parseInt(style));
        if (parseInt(style) > 0 && parseInt(style) <= 40) {
          $scope.passStatus = "Week";
          $scope.disabledJoin = true;
        } else if (parseInt(style) > 40 && parseInt(style) <= 70) {
          $scope.passStatus = "Good";
          $scope.disabledJoin = false;
        } else if (parseInt(style) > 70 && parseInt(style) <= 90) {
          $scope.passStatus = "Good";
          $scope.disabledJoin = false;
          //              $scope.disabledJoin = false;
        } else if (parseInt(style) > 90) {
          $scope.passStatus = "Strong";
          $scope.disabledJoin = false;
        } else {
          $scope.passStatus = "Week";
          $scope.disabledJoin = false;
        }
      }, 500);
    }
  });

});