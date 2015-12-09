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
  	 	$scope.$apply();
  	 }

  	 /* 
  	  * When Password Changed
  	  */
  	  $scope.$watch('user.password', function (newVal, oldVal) {
  	  	var style = $(".progress-bar").width() / $('.progress-bar').parent().width() * 100;
  	  	if(parseInt(style) > 0 && parseInt(style) <= 40 ) {
  	  		$scope.passStatus = "Week";
  	  	}else if (parseInt(style) > 40 && parseInt(style) <= 70) {
  	  		$scope.passStatus = "Good";
  	  	}else if(parseInt(style) > 75) {
  	  		$scope.passStatus = "Strong";
  	  	}else {
  	  		$scope.passStatus = "Week";
  	  	}
  	  });
  	
  });

 