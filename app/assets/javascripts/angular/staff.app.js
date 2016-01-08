/*
 * Intialize The Join Application
 */

var app = angular.module('staffAPP', []);

/*
 * Intialize The Controller
 */
app.controller('staffController', function($scope, $timeout, $http) {
  $scope.staff = {};
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

  /*
   * Enable the submit button when skills added
   */
   $scope.skillsAdded = function (value) {
    //console.log('here', value);
    if(value === '1') {
      $scope.staff.skills = 'true';
    }else{
      //$scope.staff.skills = '';
       $timeout(function () {
            $scope.addStaff.skills.$dirty = true;
       }, 0);
    }
   }

   /*
    * Add New Staff Member
    */
    $scope.addNewStaff = function () {
      $http.post('/add_staff/create', $scope.staff).success(function (response) {
        //console.log('new staff added');
        if(response.success) {
          swal({   
            title: 'Staff Added',
            text: 'New staff member is added to company',
            type: 'success',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',   
            confirmButtonText: 'Go to home',   
            closeOnConfirm: false 
          }, function() {   
            window.location.href = "/company_home";
            //swal(     'Deleted!',     'Your file has been deleted.',     'success'   ); 
          }); 
        }else if(!response.success && response.code === 'plan_expired') {
          swal({  
                 title: 'Plan Expired',   
                 text: 'Your add staff limit is reached for the current plan, please upgrade you plan',   
                 type: 'warning',   
                 //showCancelButton: true,   
                 confirmButtonColor: '#3085d6',   
                 cancelButtonColor: '#d33',   
                 confirmButtonText: 'Yes, Upgrade!',  
                 //cancelButtonText: 'No, cancel plx!',   
                 confirmButtonClass: 'confirm-class',   
                 cancelButtonClass: 'cancel-class',   
                 closeOnConfirm: true,   
                 closeOnCancel: true 
               }, function(isConfirm) {   
                if (isConfirm) {     
                  window.location.href = "/addon_plans";
                } else { 
                } 
              });

        }else if(!response.success && response.code === 'error') {
          sweetAlert('Something wrong...',
            response.msg,
            'error');
          $scope.staff.email = '';
        }
        
      }).error(function () {
        console.log('error adding new staff');
      });
    }

});