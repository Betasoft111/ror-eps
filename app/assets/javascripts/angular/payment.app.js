/*
 * Starting The Angular JS Application
 */

 var app = angular.module('epsPayment', []);

/*
 * Intialize The Payment Controller
 */

 app.controller('paymentController', function($scope) {

 	 $scope.showFirstTab = true;
	 $scope.showSecondTab = false;
	 $scope.showThirdTab = false;
	 $scope.selectedTab = 1;

	 $scope.selectPlan = function (id, name, price) {
	 	$scope.selectedPlan = {};
	 	$scope.selectedPlan.id = id;
	 	$scope.selectedPlan.name = name;
	 	$scope.selectedPlan.price = price;

	 	$('#plan_id').val(id);
	 	$('#plan_id_paypal').val(id);
	 	$('#script-key').attr('data-description', name);
	 	$('#script-key').attr('data-amount', price);
	 	
	 }

	 $scope.proceedToPay = function () {
	 	 $scope.showFirstTab = false;
	 	 $scope.showSecondTab = true;
	 	 $scope.selectedTab = 2;
	 }

	 $scope.changeTab = function(value) {
	 	if (value === '1') {

	 		$scope.showFirstTab = true;
	 	 	$scope.showSecondTab = false;
	 	 	$scope.selectedTab = 1;

	 	}else if(value === '2' && $scope.selectedPlan.id) {

	 		$scope.showFirstTab = false;
	 	 	$scope.showSecondTab = true;
	 	 	$scope.selectedTab = 2;
	 	}
	 }
 });
