/*
 * Intialize The Join Application
 */

var app = angular.module('staffAPP', []);

/*
 * Intialize The Controller
 */
app.controller('staffController', function($scope, $timeout, $http) {

  /*
   * Set the submit button value
   */
  $scope.disabledJoin = true;

  /*
   * Check Skills Added
   */
  $scope.skillsAdded = function(value) {
    //console.log('Model value ', $scope.staff.skills, '=========>', value);
  }

  /*
   * Change Avl Value
   */
  $scope.cahngeAvl = function(date) {
    
    $scope.staff.availability = date;
  }

  /*
   * Check For Duplicate Email
   */
  $scope.checkEmail = function() {
    $http.post('/api/check_staff_email',{email: $scope.staff.email}).success(function (response) {
      if(response.success) {
        $scope.errMsg = response.user;
        $scope.duplicateEmail = true;
      }else{
        $scope.errMsg = '';
        $scope.duplicateEmail = false;
      }
    }).error(function (err){
      console.log('Error checking the duplicate emails', err);
    });
  }

  /*
   * Get the details for selected staff
   */
  $scope.getDetails = function(id) {
    $http.get('/api/staff_edit/' + id).success(function (response) {
      $scope.staff = response.user;
      if(response && response.user) {
        $scope.staff.qualification = response.user.qualification;
        $scope.staff.staff_price = parseInt(response.user.staff_price);
        if(response.user.is_private) {
          $scope.staff.is_private = '1';
        }else{
          $scope.staff.is_private = '0';
        }
      }
    }).error(function (err){
      console.log('Error checking the duplicate emails', err);
    });
  }

});