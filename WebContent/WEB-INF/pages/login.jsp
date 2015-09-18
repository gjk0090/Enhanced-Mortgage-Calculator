<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Welcome to EMC Page</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular-resource.min.js"></script>
<script src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
<script src="https://www.google.com/jsapi"></script>
<script>
	$("document")
		.ready(
				function(){
					$("homeInsturance_ads").click(function(){
						$.ajax({
							url : "adsClicked",
							type : "get",
							dataType : "html",
							async : false,
							data : {},
							success : function(response) {
							},
							error : function(msg) {
								alert(msg);
							}
						});
					});
				});
	var myApp = angular.module("mainModule", [])
		myApp.controller("mainController", function ($scope, $http) {
			$scope.simpleDataset = {
	  			credit: 3,
	  			amount: 0,
	  			down: 0,
	  			percent: 0,
	  			term: "",
	  			isARM: false,
	  			initPeriod:0,
	  			addtionPay:0,
	  			additionMonth:0
	  		};
			$scope.allAd = [];
	    	$scope.addAdCount=function(adId){
  	    		var params = $.param({
  		     		adId: adId
  				});
  	    		$http({
  	    			method: "POST",
  	    			url: "edit_ad.html",
  	    			data: params,
  	    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
  	    			}).success(function (msg) {
  	      		});
  	    	}; 		
	  		$scope.rate = 0;
	  		$scope.min = 0;
	  		$scope.allRate=[];
	  		$scope.results=[];
	  		$scope.savedMoney=null;
	  		$scope.canShow = false;
	  		
	  		$scope.updateDown = function(){$scope.simpleDataset.down=$scope.format($scope.simpleDataset.percent*$scope.simpleDataset.amount/100);};
	  		$scope.updatePercent = function(){$scope.simpleDataset.percent=$scope.format($scope.simpleDataset.down/$scope.simpleDataset.amount*100);};
	  		$scope.format=function(number){return Math.round(number*1000)/1000;}
	  		var oriSimpleDataset = angular.copy($scope.simpleDataset);

	  	    $scope.resetForm = function () {
	  	      	$scope.simpleDataset = angular.copy(oriSimpleDataset);
	  	      	$scope.cal.$setPristine();
	  	      	$scope.canShow = false;
        		$scope.rate = 0;
        		$scope.min = 0;
	  	    };

	  	    $scope.isSimpleDatasetChanged = function () {
	  	      	return !angular.equals($scope.simpleDataset, oriSimpleDataset);
	  	    };
	  	    
	  	    $scope.getRate = function (term){
	  	    	$http({
	    			method: "GET",
	    			url: "rest/get_rate/"+term,
	    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	    		}).success(function (data, status, headers, config) {

	        		$scope.rate = data.rate;
	        		$scope.min = data.min;
	      		});
	  	    };
	  	    
	  	    $scope.getAllRate = function(){
	  	    	$http({
	    			method: "GET",
	    			url: "rest/get_all_rate/",
	    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	    		}).success(function (data, status, headers, config) {

	        		$scope.allRate=data;
	      		});
	  	    }
	  	    
	  	    $scope.editRate = function(index,target){
	  	    	var newTerm=$scope.allRate[index].term;
	  	    	var newRate=target.parentNode.parentNode.childNodes[5].childNodes[0].value;
	  	    	var newMin=target.parentNode.parentNode.childNodes[9].childNodes[0].value;
	  	    	//alert(index+" "+$scope.allRate[index].term+" "+target.parentNode.parentNode.childNodes[9].childNodes[0].value);
	  	    	if (newMin-Math.floor(newMin)==0){
	  	    	$http({
	    			method: "GET",
	    			url: "rest/edit_rate/"+newTerm+":"+newRate+":"+newMin,
	    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	    		}).success(function (data, status, headers, config) {
					if(data=="1"){
						$scope.getAllRate();
					}else{
						alert("Something wrong!");
					}
	        		
	      		});
	  	    	}else{
	  	    		alert("Minimun Amount has to be Integer!");
	  	    	}
	  	    }

	  		$scope.calculate = function (simpleDataset, resultVarName) {
			    var params = $.param({
		        	credit: simpleDataset.credit,
		        	amount: simpleDataset.amount,
		        	down: simpleDataset.down,
		        	term: simpleDataset.term,
		  			isARM: simpleDataset.isARM,
		  			initPeriod: simpleDataset.initPeriod,
		  			addtionPay: simpleDataset.addtionPay,
		  			additionMonth: simpleDataset.additionMonth
			    });
			    
			    var url = "calculate_simple.html";
			    if(simpleDataset.isARM){url="calculate_arm.html";}
			    
	    		$http({
	    			method: "POST",
	    			url: url,
	    			data: params,
	    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	    		}).success(function (data, status, headers, config) {
	        		$scope[resultVarName] = data;

	        		$scope.results = data.result;
	        		$scope.savedMoney = data.savedMoney;
	        		$scope.canShow = true;
	        		
	        		drawChart(simpleDataset.amount,data.result[data.result.length-1].totalInterest);
	        		drawChartB(data.result);
	        		    
	      		}) .error(function (data, status, headers, config) {
	        		$scope[resultVarName] = "SUBMIT ERROR";
	      		});
	  		};
		});	

	myApp.controller("loginController", function ($scope, $http) {
		$scope.userInfo = {
	  			inputName: '${input_name}',
	  			inputPass: '${input_pass}'
	  		};
	  		var oriUserInfo = angular.copy($scope.userInfo);

	  	    $scope.resetForm = function () {
	  	      	$scope.userInfo = angular.copy(oriUserInfo);
	  	      	$scope.f.$setPristine();
	  	    };

	  	    $scope.isUserInfoChanged = function () {
	  	      	return !angular.equals($scope.userInfo, oriUserInfo);
	  	    };
	  	    
	  	    $scope.register = {
	  	    	email:'',
	  	    	nickname:'',
	  	    	password:'',
	  	    	confirmPass:''
	  	    };
	  	    
	  	    $scope.samePass = true;
	  	    $scope.isEmail = true;
	  	    $scope.emailExist = false;
	  	    
	  	    $scope.checkSame = function(){
	  	    	if($scope.register.password==$scope.register.confirmPass){
	  	    		$scope.samePass = true;
	  	    	}else{
	  	    		$scope.samePass = false;
	  	    	}
	  	    };
	  	    
	  	    $scope.emailBlur = function(){
	  	    	$scope.isEmail = false;
	  	    	
	  	    	//verify if this email is valid
	  	    	$http({
	    			method: "POST",
	    			url: "rest/validate_email",
	    			data: $scope.register.email,
	    			async: false,
	    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	    		}).success(function (msg) {
	    			if(msg=="3"||msg=="9") {
			    		//registerUser();
			    		$scope.isEmail = true;
			    	}else{
			    		$scope.isEmail = false;		    		
			    	}
	      		});
	  	    	
	  	    	//verify if this user already exists
	  	    	
	  			var params = $.param({
	  		     	email: $scope.register.email
	  			});
	  	    	$http({
	  	    		method: "POST",
	  	    		url: "email_exist.html",
	  	    		data: params,
	  	    		headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	  	    	}).success(function (msg) {
	  	    		if(msg=="0") {
	  			   		
	  			   		$scope.emailExist = false;
	  			   	}else{
	  			   		$scope.emailExist = true;		    		
	  			   	}
	  	      	});
	  	    	
	  	    };
	  	    
	  	    $scope.registerUser = function(){
	  	    	var params = $.param({
	  		     	username: $scope.register.email,
	  		     	password: $scope.register.password,
	  		     	nickname: $scope.register.nickname
	  			});
	  	    	$http({
	  	    		method: "POST",
	  	    		url: "register_user.html",
	  	    		data: params,
	  	    		async: false,
	  	    		headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	  	    	}).success(function (msg) {
	  	    		if(msg=="registered") {
	  	    			//$scope.userInfo.inputName = $scope.register.email;
	  	    			//$scope.userInfo.inputPass = $scope.register.password;

	  	    			$("#j_username").val($scope.register.email);
	  	    			$("#j_password").val($scope.register.password);
	  	    			$("#loginForm").submit();
	  	    			//$("#login").trigger("click");

	  			   	}
	  	      	});
	  	    };
	  	    
	  	    $scope.forgotPass = function(){
	  	    	
	  	    	var params = $.param({
	  		     	email: $scope.userInfo.inputName
	  			});
	  	    	
	  	    	if(!f.j_username.$invalid){
	  	    		
	  	    	$http({
	  	    		method: "POST",
	  	    		url: "forgot_password.html",
	  	    		data: params,
	  	    		headers: {'Content-Type': 'application/x-www-form-urlencoded'}
	  	    	}).success(function (msg) {
	  	    		if(msg=="1") {
	  			   		myAlert("Sent new password to your email.");
	  			   	}else{
	  			   		myAlert("Invalid email. Failed to reset password.");
	  			   	}
	  	      	});
	  	    	
	  	    	}
	  	    };
});	
</script>
<style>
		.alert{color:green;position:absolute;padding:8px;background:#eee;border:1px solid #ccc;left:40%;z-index:9999;display:none;}
		.error{color:red;}
</style>
	
<script>

	 	function myAlert(content){ 
            if(!$('#myAlert').is(':visible')){ 
                $('#myAlert').css({display:'block', top:'-100px'}).text(content).animate({top: '+100'}, 500, function(){ 
                    setTimeout(out, 1500); 
                }); 
            }
        }; 

    	function out(){ 
        	$('#myAlert').animate({top:'0'}, 500, function(){ 
            	$(this).css({display:'none', top:'-100px'}); 
        	}); 
    	} 
</script>
<style>
.fade
{
        opacity:0.6;
}
.fade:hover
{
        opacity:1;
}
.grow:hover
{
        -webkit-transform: scale(1.2);
        -ms-transform: scale(1.2);
        transform: scale(1.2);
}
	div.background1 {
	padding:0px;
	background-size:contain;
    background: url(pic/background.jpg);
}
	div.transbox1 {
	width:80%;
    background-color: #00000F;
    height:100%;
    opacity: 0.6;
    margin:auto;
    filter: alpha(opacity=60); /* For IE8 and earlier */
}


@media only screen and (max-width: 1480px) {
	div.transbox1 {
	width:100%;
    background-color: #00000F;
    height:100%;
    opacity: 0.6;
    margin:auto;
    filter: alpha(opacity=60); /* For IE8 and earlier */
	}
}

.styled-select select {
	width: 100%;
  	height: 34px;
  	padding: 6px 12px;
  	font-size: 14px;
  	line-height: 1.42857143;
  	color: #555;
  	background-color: #fff;
  	background-image: none;
  	border: 1px solid #ccc;
  	border-radius: 4px;
  	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
   }
.distinct-label label {
	width: 100%;
  	height: 34px;
  	padding: 6px 12px;
  	font-size: 14px;
  	line-height: 1.42857143;
  	color: #555;
  	background-color: #fff;
  	background-image: none;
  	border: 1px solid #ccc;
  	border-radius: 4px;
  	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>
</head>
<body ng-app="mainModule">
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<img src="pic/icon.jpg" class="img-responsive">
			</div>
			<div class="col-md-2 col-md-offset-6">
				<ul class="nav nav-tabs" role="tablist">
  					<li class="dropdown">
    					<a class="dropdown-toggle" data-toggle="dropdown" href="#" id="dropdownMenu1">
      						Account <span class="caret"></span>
    					</a>
    					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
    						<li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#loginModal">Login</a></li>
    						<li role="presentation"><a role="menuitem" tabindex="-1" href="#" data-toggle="modal" data-target="#registerModal">Register</a></li>
    					</ul>
  					</li>
				</ul>
			</div>
		</div>
	</div>
<div class="container-fluid" ng-controller="mainController">
<div class="background1">
	<div class="transbox1">
		<div class="row clearfix" style="position:relative;padding-top:5%">
			<form id="cal" name="cal" novalidate>
						<div class="row clearfix">
					<div class="col-md-4 column">
							<div class="form-group">
								<label for="amount" class="col-sm-2 control-label col-sm-offset-2 input-lg" style="color:#ffffff">Amount</label>
								<div class="col-sm-6 col-sm-offset-1">
									<div class="input-group">
  										<span class="input-group-addon">$</span>
  											<input type="number" class="form-control" id="amount" name="amount" ng-model="simpleDataset.amount" ng-change="updatePercent()" min="{{min}}" required/>
									</div>
								</div>
							</div>
					</div>
					<div class="col-md-4 column">
							<div class="form-group">
								<label for="credit" class="col-sm-4 control-label input-lg" style="color:#ffffff">Credit level</label>
								<div class="col-sm-6 col-sm-offset-1">
									<div class="styled-select">
										<select  ng-model="simpleDataset.credit" required>
											<option value="1">Poor</option>
											<option value="2">Average</option>
											<option value="3">Good</option>
											<option value="4">Excellent</option>
										</select>
									</div>
								</div>
							</div>
					</div>
				</div>
				<div class="row clearfix" style="position:relative;padding-top:2%">
					<div class="col-md-4 column">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label col-sm-offset-1 input-lg" style="color:#ffffff">Down_Payment</label>
								<div class="col-sm-6 col-sm-offset-2">
									<div class="input-group">
  										<span class="input-group-addon">$</span>
  										<input type="number" class="form-control" id="down" name="down" ng-change="updatePercent()" ng-model="simpleDataset.down" required min="0" max="{{simpleDataset.amount}}"/>
									</div>
								</div>
							</div>
					</div>
					<div class="col-md-4 column">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label col-sm-offset-1 input-lg" style="color:#ffffff">Percent</label>
								<div class="col-sm-6 col-sm-offset-2">
									<div class="input-group">
  										<input type="number" class="form-control" id="percent" name="percent" ng-change="updateDown()" ng-model="simpleDataset.percent" min="0" max="100" />
										<span class="input-group-addon" style="color:#000000">%</span>
									</div>
								</div>
							</div>
					</div>
				</div>
				<div class="row clearfix" style="position:relative;padding-top:2%">
					<div class="col-md-4 column">
							<div class="form-group">
								<c:if test="${not empty lists}">
									<label for="term" class="col-sm-2 control-label col-sm-offset-2 input-lg" style="color:#ffffff">Term</label>
									<div class="col-sm-6 col-sm-offset-1">
										<div class="input-group">
											<div class="styled-select">
   												<select ng-model="simpleDataset.term" required name="term" ng-change="getRate(simpleDataset.term)">
      												<c:forEach var="listValue" items="${lists}">
														<option value="${listValue}" >${listValue}</option>
													</c:forEach>
   												</select>
											</div>
											<span class="input-group-addon" style="color:#000000">Years</span>
										</div>
									</div>
								</c:if>
							</div>
					</div>
					<div class="col-md-4 column">
							<div class="form-group">
								<label for="rate" class="col-sm-2 control-label col-sm-offset-1 input-lg" style="color:#ffffff">Rate</label>
								<div class="col-sm-6 col-sm-offset-2">
									<div class="input-group">
										<input type="text" class="form-control" id="rate" name="rate" value="{{rate}}" disabled/>
										<span class="input-group-addon" style="color:#000000">%</span>
									</div>
								</div>
							</div>
					</div>
					<div class="col-md-4 column">
							<div class="form-group">
								<label for="min" class="col-sm-4 control-label input-lg" style="color:#ffffff">Minimum Amount</label>
								<div class="col-sm-6">
									<div class="input-group">
  										<span class="input-group-addon">$</span>
  										<input type="text" class="form-control" id="rate" name="rate" value="{{min}}" disabled/>
									</div>
								</div>
							</div>
					</div>
				</div>
				<div class="row clearfix" style="position:relative;padding-top:3%;padding-bottom:1%">
					<div class="col-md-2 col-md-offset-3 column">
						<button type="submit" class="btn btn-primary btn-lg btn-block" ng-click="calculate(simpleDataset, 'ajaxResult')" ng-disabled="cal.$invalid || cal.down.$error.max|| simpleDataset.amount<min">Calculate it now</button>
					</div>
					<div class="col-md-2 col-md-offset-1 column">
						<button type="button" class="btn btn-primary btn-lg btn-block" ng-click="resetForm()" ng-disabled="!isSimpleDatasetChanged()">Reset</button>
					</div>
				</div>	  
			</form>
		</div>
	</div>
</div>
<div ng-show="canShow">
	<div class="col-md-6 col-md-offset-3 column">
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
        		<tr>
		          <th>Month</th>
		          <th>Payment</th>
		          <th>Balance</th>
		          <th>Interest</th>
		          <th>Total Interest</th>
        		</tr>
      		</thead>
      		<tbody>
        		<tr ng-repeat="result in results">
          			<td>{{result.month}}</td>
          			<td>{{result.monthPayment}}</td>
          			<td>{{result.balance}}</td>
          			<td>{{result.interest}}</td>
          			<td>{{result.totalInterest}}</td>
        		</tr>
      		</tbody>
		</table>
	</div>
	</div>

</div>
<div style="position: fixed; bottom: 5px; right: 5px;" id="video_area">
	<a href="http://www.johnlewis.com/" target="_blank" id="homeInsturance_ads" ng-click="addAdCount(1)">
		<video autoplay="autoplay" muted="muted" style="width: 300px; height: auto;" id="homeInsturance_commercial"> <source src="<c:url value="/video/John Lewis Home Insurance Advert.mp4"/>">
		</video>
	</a>
	</div>	  
</div>
<div class="container">

	<div class="row clearfix">
		<div class="col-md-4 column">
			<h2>
				Rent or Buy?
			</h2>
			<img src="pic/house1.jpg" class="img-circle fade" width="300" height="300">
			<p>
				Not sure if you want rent or buy? We can help do the math, and make the right decision.
			</p>
			<p>
				<a class="btn grow" target="_blank" href="http://www.trulia.com/rent_vs_buy/">Compare costs »</a>
			</p>
		</div>
		<div class="col-md-4 column">
			<h2>
				Get Ready to Sell
			</h2>
			<img src="pic/house.jpg" class="img-circle fade" width="300" height="300">
			<p>
				Instantly find out your home's value and connect with a local agent to guide you through the selling process.
			</p>
			<p>
				<a class="btn grow" target="_blank" href="http://www.trulia.com/for_sale/Princeton_Junction,NJ">View details »</a>
			</p>
		</div>
		<div class="col-md-4 column">
			<h2>
				Search like a local
			</h2>
			<img src="pic/house2.jpg" class="img-circle fade" width="300" height="300">
			<p>
				Get the scoop on nearby schools, crime, and more, right down to the closest grocery store.
			</p>
			<p>
				<a class="btn grow" target="_blank" href="http://www.trulia.com/sell?ts=trulia&tscamp=home_page_module">Start Exploring »</a>
			</p>
		</div>
	</div>
</div>
<div class="container" ng-controller="loginController">
<div class="alert" id="myAlert">Some alert message.</div>	
	<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        		<h4 class="modal-title" id="myModalLabel">Welcome</h4>
      		</div>
      		<div class="modal-body">
      			<form class="form-horizontal" role="form" name="f" action="<c:url value='j_spring_security_check'/>" method="POST" id="loginForm" novalidate>
  					<div class="error" ng-show=" ('${param.login_error}'== '1') && f.$pristine">
						<small>The username or password is incorrect!</small>
					</div>	
					<div class="error" ng-show="f.j_username.$dirty && f.j_username.$invalid">
	    				<small class="error" ng-show="f.j_username.$error.required">
	        				Please input username!
	    				</small>
					</div>
  					<div class="form-group">
    					<label for="login-name" class="col-sm-2 control-label">Email</label>
    					<div class="col-sm-10">
      						<input type="text" class="form-control" placeholder="Please enter your email" name="j_username" id="j_username" ng-model="userInfo.inputName" required />
    					</div>
  					</div>
  					<div class="form-group">
    					<label for="login-pass" class="col-sm-2 control-label">Password</label>
    					<div class="col-sm-10">
      					<input type="password" class="form-control" placeholder="Please enter your password" name="j_password" id="j_password" ng-model="userInfo.inputPass" required />
    					</div>
  					</div>
  					
  					<div class="modal-footer">
        				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        				<button type="submit" class="btn btn-primary" id="login" ng-disabled="f.$invalid">Login</button>
        				<a href="#" ng-click="forgotPass()">Lost your password?</a>
      				</div>
				</form>
      		</div>
    	</div>
	</div>
</div>
	<!-- Register Modal -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        		<h4 class="modal-title" id="myModalLabel">Register to explore more!</h4>
	      		</div>
	      		<div class="modal-body">
	      			<form class="login-form" name="register_form" novalidate>
            			<div class="form-group">
              				<input type="email" class="form-control login-field" value="" placeholder="Enter your email" name="register_email" id="register_email" ng-model="register.email" ng-blur="emailBlur()" required />
              				<label class="login-field-icon fui-mail" for="register_email"></label>
              				<small class="error" ng-show="!isEmail">Email not valid!</small>
              				<small class="error" ng-show="emailExist">You are already one of us!</small>
            			</div>
            			
						<div class="form-group">
              				<input type="text" class="form-control login-field" value="" placeholder="Pick a nick name" name="register_nickname" id="register_nickname" ng-model="register.nickname" ng-minlength="3" ng-maxlength="10" required />
              				<label class="login-field-icon fui-user" for="register_nickname"></label>
            			</div>
            			<div class="form-group">
              				<input type="password" class="form-control login-field" value="" placeholder="Password" name="register_password" id="register_password" ng-model="register.password" ng-change="checkSame()" ng-minlength="3" ng-maxlength="10" required/>
              				<label class="login-field-icon fui-lock" for="register_password"></label>
            			</div>
            			<div class="form-group">
              				<input type="password" class="form-control login-field" value="" placeholder="Confirm Password" name="confirm_password" id="confirm_password" ng-model="register.confirmPass" ng-change="checkSame()" required/>
              				<label class="login-field-icon fui-lock" for="confirm_password"></label>
              				<small class="error" ng-show="!samePass">Password not match!</small>
            			</div>
            		</form>
				</div>
				<div class="modal-footer">
	        		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
	        		<button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="registerUser()" ng-disabled="register_form.$invalid||!samePass||!isEmail||emailExist">Register</button>
	      		</div>
			</div>
		</div>
	</div>
</div>

<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="js/jquery.ui.touch-punch.min.js"></script>
<script src="js/bootstrap-select.js"></script>
<script src="js/bootstrap-switch.js"></script>
<script src="js/flatui-checkbox.js"></script>
<script src="js/flatui-radio.js"></script>
<script src="js/jquery.tagsinput.js"></script>
<script src="js/jquery.placeholder.js"></script>
</body>
</html>