/*
 * Starting The Angular JS Application
 */

 var app = angular.module('epsPayment', []);

/*
 * Intialize The Payment Controller
 */

 app.controller('paymentController', function ($scope, $location, $anchorScroll, anchorSmoothScroll) {

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
	 	$('#hidden_amount').val(price);
	 	amount = price;
	 	$('#script-key').attr('data-description', name);
	 	$('#script-key').attr('data-amount', price);
	 	
	 }

	 $scope.proceedToPay = function () {
	 	 $scope.showFirstTab = false;
	 	 $scope.showSecondTab = true;
	 	 $scope.selectedTab = 2;
	 	 anchorSmoothScroll.scrollTo('pay');
	 	 
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

	 $scope.changePlan = function(planId) {
	 	$scope.selected_plan = planId;
	 }
 });

app.service('anchorSmoothScroll', function(){
    
    this.scrollTo = function(eID) {

        // This scrolling function 
        // is from http://www.itnewb.com/tutorial/Creating-the-Smooth-Scroll-Effect-with-JavaScript
        
        var startY = currentYPosition();
        var stopY = elmYPosition(eID);
        var distance = stopY > startY ? stopY - startY : startY - stopY;
        if (distance < 100) {
            scrollTo(0, stopY); return;
        }
        var speed = Math.round(distance / 100);
        if (speed >= 20) speed = 20;
        var step = Math.round(distance / 25);
        var leapY = stopY > startY ? startY + step : startY - step;
        var timer = 0;
        if (stopY > startY) {
            for ( var i=startY; i<stopY; i+=step ) {
                setTimeout("window.scrollTo(0, "+leapY+")", timer * speed);
                leapY += step; if (leapY > stopY) leapY = stopY; timer++;
            } return;
        }
        for ( var i=startY; i>stopY; i-=step ) {
            setTimeout("window.scrollTo(0, "+leapY+")", timer * speed);
            leapY -= step; if (leapY < stopY) leapY = stopY; timer++;
        }
        
        function currentYPosition() {
            // Firefox, Chrome, Opera, Safari
            if (self.pageYOffset) return self.pageYOffset;
            // Internet Explorer 6 - standards mode
            if (document.documentElement && document.documentElement.scrollTop)
                return document.documentElement.scrollTop;
            // Internet Explorer 6, 7 and 8
            if (document.body.scrollTop) return document.body.scrollTop;
            return 0;
        }
        
        function elmYPosition(eID) {
            var elm = document.getElementById(eID);
            var y = elm.offsetTop;
            var node = elm;
            while (node.offsetParent && node.offsetParent != document.body) {
                node = node.offsetParent;
                y += node.offsetTop;
            } return y;
        }

    };
    
});