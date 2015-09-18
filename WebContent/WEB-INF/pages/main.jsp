<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>EMC</title>
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
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular-resource.min.js"></script>
<script src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
<script src="https://www.google.com/jsapi"></script>

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


<script>
	google.load('visualization', '1', {'packages':['corechart']});
	//Set a callback to run when the Google Visualization API is loaded.

	function drawChartB(resultI){
		var result=resultI;
		var data = new google.visualization.DataTable();
		data.addColumn('number', 'Month');
		data.addColumn('number', 'Principal Pay');
		data.addColumn('number', 'Interest');
		for(i = 0; i < result.length; i++)
    		data.addRow([i+1, result[i].monthPayment-result[i].interest,result[i].interest]);
		var formatter = new google.visualization.NumberFormat({pattern:'###.##'});
	   		formatter.format(data, 1);  
			// Instantiate and draw our chart, passing in some options.
			var chart = new google.visualization.LineChart(document.getElementById('chart_line'));
			chart.draw(data, {'title':'Principal Pal & Interest', 'width':600,'height':400});
		}

	function drawChart(a,b) {
		// Create our data table out of JSON data loaded from server.
		//var data = new google.visualization.DataTable(jsonData);
		var data = new google.visualization.DataTable();
			data.addColumn('string', 'name');
			data.addColumn('number', 'number');
			data.addRows([
				['Amount', a],
				['Total Interest', b]
			]);
		// Set chart options
		var options = {is3D: true,'title':'Amount & Total Interest','width':600,'height':400};
		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
			chart.draw(data, options);
	}
	function closeVideo() {
		$("#video_area").remove();
	};
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
  				initPeriod:3,
  				addtionPay:0,
  				additionMonth:0
  			};
			$scope.allAd = [];
			$scope.allAct = [];
			$scope.intime = (new Date()).getTime();
			
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
	    	$scope.timeStay = function() {
				var params = $.param({
					timeStay : (new Date()).getTime()- $scope.intime,
					userId : '${userid}'
				});
				//alert($scope.intime+"  "+(new Date()).getTime()+" "+($scope.intime-(new Date()).getTime()));
				$http(
					{
						method : "POST",
						url : "add_act.html",
						data : params,
						headers : {
							'Content-Type' : 'application/x-www-form-urlencoded'
						}
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
  	    };
  	    
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
  	    		alert("minimum Amount has to be Integer!");
  	    	}
  	    };
  	    
  	    
  	    
  	   $scope.userProfile = {
    			username:"",
    			password:"",
    			nickname:"",
    	};
    		
  	    $scope.getUser = function(){
  	    	$http({
    			method: "POST",
    			url: "get_user.html",
    			async:false,
    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
    		}).success(function (data, status, headers, config) {

        		//alert(JSON.stringify(data));
    			$scope.userProfile.username=data.userName;
    			$scope.userProfile.password=data.password;
    			$scope.userProfile.nickname=data.nickName;
      		});
  	    }
  	    
  	    $scope.editUser = function(){
  	    	var params = $.param({
  	    		nickname:$scope.userProfile.nickname,
  	    		password:$scope.userProfile.password
  	    	});
  	    	
  	    	$http({
    			method: "POST",
    			data: params,
    			url: "edit_user.html",
    			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
    		}).success(function (data, status, headers, config) {

				if(data=="1"){
					myAlert("Edit sucseeded!");
					//$("#logout").trigger("click");
					location.reload();//refresh page
				}
      		});
  	    }
  	    
  	    
  	  $scope.getAllAd = function() {
	    	//alert("edsdsd");
			$http(
					{
						method : "GET",
						url : "rest/ad/get_all_ad/",
						headers : {
							'Content-Type' : 'application/x-www-form-urlencoded'
						}
					}).success(
					function(data, status, headers, config) {

						$scope.allAd = data;
					});
		};
		
		$scope.getAllAct = function() {
			$http(
					{
						method : "GET",
						url : "rest/act/get_all_act/",
						headers : {
							'Content-Type' : 'application/x-www-form-urlencoded'
						}
					}).success(
					function(data, status, headers, config) {
						$scope.allAct = data;
					});
		};
  	    
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
</script>
<style>
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
.CSSTableGenerator {
	margin:0px;padding:0px;
	width:100%;
	box-shadow: 10px 10px 5px #888888;
	border:1px solid #ffffff;
	
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
	
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
	
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
	
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}.CSSTableGenerator table{
    border-collapse: collapse;
        border-spacing: 0;
	width:100%;
	height:100%;
	margin:0px;padding:0px;
}.CSSTableGenerator tr:last-child td:last-child {
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
}
.CSSTableGenerator table tr:first-child td:first-child {
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}
.CSSTableGenerator table tr:first-child td:last-child {
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
}.CSSTableGenerator tr:last-child td:first-child{
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
}.CSSTableGenerator tr:hover td{
	
}
.CSSTableGenerator tr:nth-child(odd){ background-color:#aae0ff; }
.CSSTableGenerator tr:nth-child(even)    { background-color:#ffffff; }.CSSTableGenerator td{
	vertical-align:middle;
	
	
	border:1px solid #ffffff;
	border-width:0px 1px 1px 0px;
	text-align:center;
	padding:10px;
	font-size:14px;
	font-family:Helvetica;
	font-weight:normal;
	color:#000000;
}.CSSTableGenerator tr:last-child td{
	border-width:0px 1px 0px 0px;
}.CSSTableGenerator tr td:last-child{
	border-width:0px 0px 1px 0px;
}.CSSTableGenerator tr:last-child td:last-child{
	border-width:0px 0px 0px 0px;
}
.CSSTableGenerator tr:first-child td{
		background:-o-linear-gradient(bottom, #003f7f 5%, #003f7f 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #003f7f), color-stop(1, #003f7f) );
	background:-moz-linear-gradient( center top, #003f7f 5%, #003f7f 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#003f7f", endColorstr="#003f7f");	background: -o-linear-gradient(top,#003f7f,003f7f);

	background-color:#003f7f;
	border:0px solid #ffffff;
	text-align:center;
	border-width:0px 0px 1px 1px;
	font-size:15px;
	font-family:Helvetica;
	font-weight:bold;
	color:#ffffff;
}
.CSSTableGenerator tr:first-child:hover td{
	background:-o-linear-gradient(bottom, #003f7f 5%, #003f7f 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #003f7f), color-stop(1, #003f7f) );
	background:-moz-linear-gradient( center top, #003f7f 5%, #003f7f 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#003f7f", endColorstr="#003f7f");	background: -o-linear-gradient(top,#003f7f,003f7f);

	background-color:#003f7f;
}
.CSSTableGenerator tr:first-child td:first-child{
	border-width:0px 0px 1px 0px;
}
.CSSTableGenerator tr:first-child td:last-child{
	border-width:0px 0px 1px 1px;
}
</style>
</head>
<body ng-app="mainModule">
<div  ng-controller="mainController">
	<div class="container-fluid">
	
		<div class="page-header">
  			<div class="row">
				<div class ="col-md-5 col-md-offset-1">
  					<h1><span class="label label-success">Hello ${nickname}, welcome to EMC!</span></h1>
				</div>
				<div class="col-md-3">
						<ul class="nav nav-pills" ng-show="'${userrole}'=='ROLE_ADMIN'">
  							<li><a href="#" data-toggle="modal" data-target="#editRateModal" ng-click="getAllRate()">EditRate</a></li>
  							<li><a href="#" data-toggle="modal" data-target="#showAdModal" ng-click="getAllAd()">Ad Statistic</a></li>
  							<li><a href="#" data-toggle="modal" data-target="#showActModal" ng-click="getAllAct()">User Activity</a></li>
						</ul>
				</div>
				<div class="col-md-2">
					<ul class="nav nav-pills">
						<li><a href="#" data-toggle="modal" data-target="#editUserModal" ng-click="getUser()">Edit Profile</a></li>
  						<li><a href="<c:url value='/j_spring_security_logout'/>" ng-click="timeStay()">Logout</a></li>
					</ul>	
				</div>
			</div>
		</div>
	</div>
	<div >
		<div class="background1">
			<div class="transbox1">
				<div class="row clearfix" style="position:relative;padding-top:5%">
					<form  id="cal" name="cal" novalidate>
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
											<input type="text" class="form-control" id="rate" name="rate" ng-model="rate" disabled/>
											<span class="input-group-addon" style="color:#000000">%</span>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 column">
								<div class="form-group">
									<label for="min" class="col-sm-4 control-label input-lg" style="color:#ffffff" data-toggle="tooltip" data-placement="bottom" title="minimum Amount">Minimum</label>
									<div class="col-sm-6">
										<div class="input-group">
  											<span class="input-group-addon">$</span>
  											<input type="text" class="form-control" id="min" name="min" ng-model="min" disabled/>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row clearfix" style="position:relative;padding-top:2%">
							<div class="col-md-4 column">
								<div class="form-group">
									<label for="amount" class="col-sm-2 control-label col-sm-offset-2 input-lg" style="color:#ffffff" data-toggle="tooltip" data-placement="bottom" title="Adjustable-Rate Mortgages">ARM</label>
									<div class="col-sm-6 col-sm-offset-1">
										<label>
      										<input type="checkbox" ng-model="simpleDataset.isARM" ng-disabled="simpleDataset.term<4">
    									</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row clearfix">
							<div class="col-md-4 column">
								<div class="form-group">
									<label for="term" class="col-sm-2 control-label col-sm-offset-2 input-lg" style="color:#ffffff" data-toggle="tooltip" data-placement="bottom" title="Initial Period">Initial Period</label>
									<div class="col-sm-6 col-sm-offset-1">
										<div class="input-group">
											<select class="form-control" ng-model="simpleDataset.initPeriod" required ng-disabled="!simpleDataset.isARM">
												<option value="3" >3</option>
												<option value="5" >5</option>
												<option value="7" >7</option>
											</select>
											<span class="input-group-addon" style="color:#000000">Years</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row clearfix" style="position:relative;padding-top:2%">
							<div class="col-md-4 column">
								<div class="form-group">
									<label for="addpay" class="col-sm-2 control-label col-sm-offset-1 input-lg" style="color:#ffffff" data-toggle="tooltip" data-placement="bottom" title="Additional Payment">A_Payment</label>
									<div class="col-sm-6 col-sm-offset-2">
										<div class="input-group">
  											<span class="input-group-addon">$</span>
  											<input type="number" class="form-control" id="addpay" name="addpay" ng-model="simpleDataset.addtionPay" required min="0" max="{{simpleDataset.amount-simpleDataset.down}}"/>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4 column">
								<div class="form-group">
									<label for="additionalMonth" class="col-sm-2 control-label col-sm-offset-1 input-lg" style="color:#ffffff" data-toggle="tooltip" data-placement="bottom" title="Additional Month">A_Month</label>
									<div class="col-sm-6 col-sm-offset-2">
										<div class="input-group">
  											<input type="number" class="form-control" id="addmon" name="addmon" ng-disabled="simpleDataset.addtionPay==0" ng-model="simpleDataset.additionMonth" required min="0" max="{{simpleDataset.term*12}}"/>
											<span class="input-group-addon" style="color:#000000">Month</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row clearfix" style="position:relative;padding-bottom:1%;padding-top:3%">
							<div class="col-md-2 col-md-offset-3">
								<button type="submit" class="btn btn-primary btn-lg btn-block" ng-click="calculate(simpleDataset, 'ajaxResult')" ng-disabled="cal.$invalid || cal.down.$error.max|| simpleDataset.amount<min">Calculate it now</button>
							</div>
							<div class="col-md-2 col-md-offset-1">
								<button type="button" class="btn btn-primary btn-lg btn-block" ng-click="resetForm()" ng-disabled="!isSimpleDatasetChanged()">Reset</button>
							</div>
						</div>	  
					</form>
				</div>
			</div>
		</div>	  
	</div>
	<div ng-show="canShow" style="margin-top:10px";>
		<div class="container">
			<div class="row clearfix">
				<div class="col-md-6 column">
					<div class="table-responsive CSSTableGenerator">
						<table class="table-hover" ng-show="savedMoney!=0">
      						<tbody>
      							<tr>
      								<td>Money Saved</td>
      							</tr>
        						<tr>
          							<td>$ {{savedMoney}}</td>

        						</tr>
      						</tbody>
						</table>
					</div>
					<div class="table-responsive CSSTableGenerator">
						<table class="table-hover">
      						<tbody>
      							<tr>
      								<td>Month</td>
		          					<td>Payment</td>
		          					<td>Balance</td>
		          					<td>Interest</td>
		          					<td>Total Interest</td>
      							</tr>
        						<tr ng-repeat="result in results">
          							<td>{{result.month}}</td>
          							<td>$ {{result.monthPayment}}</td>
          							<td>$ {{result.balance}}</td>
          							<td>$ {{result.interest}}</td>
          							<td>$ {{result.totalInterest}}</td>
        						</tr>
      						</tbody>
						</table>
					</div>
				</div>
				<div class="col-md-6 column">

					<div id="chart_div" ng-show="canShow" style="width:100%; height:100%"></div>
					<div id="chart_line" ng-show="canShow" style="width:100%; height:100%"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<!-- Edit Rate Modal -->
		<div class="modal fade" id="editRateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  		<div class="modal-dialog modal-lg">
	    		<div class="modal-content">
	      			<div class="modal-header">
	        			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        			<h3 id="myModalLabel"><span class="label label-warning">Edit Rates and Minimum Amount</span></h3>
	      			</div>
	      			<div class="modal-body">
            			<table border="1" class="table table-bordered">
							<thead>
        						<tr>
		          					<th>Term</th>
		          					<th>Ori Rate</th>
		          					<th>New Rate</th>
		          					<th>Ori Min</th>
		          					<th>New Min</th>
		          					<th>Edit</th>
        						</tr>
      						</thead>
      						<tbody>
        						<tr ng-repeat="rate in allRate">
          							<td>{{rate.term}}</td>
          							<td>{{rate.rate}}</td>
          							<td><input type="number" value="{{rate.rate}}" max="100"></input></td>
          							<td>{{rate.min}}</td>
          							<td><input type="number" value="{{rate.min}}" max="999999"></input></td>
          							<td><button ng-click="editRate($index,$event.target)" />Edit</td>
        						</tr>
      						</tbody>
						</table>
	      			</div>
	      			<div class="modal-footer">
	        			<button type="button" class="btn btn-primary" data-dismiss="modal">Done</button>
	      			</div>
	    		</div>
	  		</div>
		</div>
			<!-- Edit User Profile Modal -->
		<div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
	  		<div class="modal-dialog">
	    		<div class="modal-content">
	      			<div class="modal-header">
	        			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	        			<h4 class="modal-title" id="myModalLabel2">Edit User Profile</h4>
	     	 		</div>
	      			<div class="modal-body">
            			<form class="login-form">
            				<div class="form-group">
              					<input type="text" class="form-control login-field"  value="{{userProfile.username}}" disabled required />
              					<label class="login-field-icon fui-mail" for="username"></label>
            				</div>
            				<div class="form-group">
              					<input type="text" class="form-control login-field" value="" ng-model="userProfile.nickname" required />
              					<label class="login-field-icon fui-user" for="nickname"></label>
            				</div>
               				<div class="form-group">
              					<input type="password" class="form-control login-field" value="" ng-model="userProfile.password" required />
              					<label class="login-field-icon fui-lock" for="password"></label>
            				</div>
            			</form>
	      			</div>
	      			<div class="modal-footer">
	        			<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
	        			<button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="editUser()">Edit</button>
	      			</div>
	    		</div>
	  		</div>
		</div>
	
			<!-- show Act Modal -->
		<div class="modal fade" id="showActModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h3 id="myActModalLabel"><span class="label label-info">This is the Activity of your customers.</span></h3>
					</div>
					<div class="modal-body">
						<table border="1" class="table table-bordered">
							<thead>
								<tr>
									<th>User Id</th>
									<th>Online Time</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="act in allAct">
									<td>{{act.userId}}</td>
									<td>{{act.timeStay}} ms</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Done</button>
					</div>
				</div>
			</div>
		</div>

			<!-- Show Ad Modal -->
		<div class="modal fade" id="showAdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h3 id="myAdModalLabel"><span class="label label-info">Ads Click Count</span></h3>
					</div>
					<div class="modal-body">
						<table border="1" class="table table-bordered">
							<thead>
								<tr>
									<th>Ad Id</th>
									<th>Count</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="ad in allAd">
									<td>{{ad.adId}}</td>
									<td>{{ad.count}}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Done</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="position: fixed; bottom: 5px; right: 5px;" id="video_area">
		<a href="http://www.johnlewis.com/" target="_blank" id="homeInsturance_ads" ng-click="addAdCount(2)">
			<video autoplay="autoplay" muted="muted" style="width: 300px; height: auto;" id="homeInsturance_commercial"> <source src="<c:url value="/video/John Lewis Home Insurance Advert.mp4"/>">
			</video>
		</a>
		<div style="position: absolute; top: 5px; right: 5px;">
			<span onclick="closeVideo()" class="glyphicon glyphicon-remove"></span>
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