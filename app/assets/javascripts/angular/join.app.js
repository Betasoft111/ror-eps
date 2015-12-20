/*
 * Intialize The Join Application
 */

 var app = angular.module('joinApp', ['ngPasswordStrength']);

 /*
  * Intialize The Controller
  */
  app.controller('joinController', function($scope) {

  	/*
  	 * Refresh The Scope
  	 */
  	 $scope.refreshScope = function() {
  	 	//$scope.$apply();
  	 }

  	 /* 
  	  * When Password Changed
  	  */
      $scope.disabledJoin = true;
  	  $scope.$watch('user.password', function (newVal, oldVal) {
  	  	var style = $(".progress-bar").width() / $('.progress-bar').parent().width() * 100;
  	  	if(parseInt(style) > 0 && parseInt(style) <= 40 ) {
  	  		$scope.passStatus = "Week";
          $scope.disabledJoin = true;
  	  	}else if (parseInt(style) > 40 && parseInt(style) <= 70) {
  	  		$scope.passStatus = "Good";
          $scope.disabledJoin = false;
  	  	}else if(parseInt(style) > 75) {
  	  		$scope.passStatus = "Strong";
          $scope.disabledJoin = false;
  	  	}else {
  	  		$scope.passStatus = "Week";
          $scope.disabledJoin = false;
  	  	}
  	  });
  	
  });

 