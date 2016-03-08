var app = angular.module("instantSearch", []);

app.filter('searchFor', function(){

	return function(arr, searchString){

		if(!searchString){
			return arr;
		}

		var result = [];

		searchString = searchString.toLowerCase();

		angular.forEach(arr, function(item){

			if(item.title.toLowerCase().indexOf(searchString) !== -1){
				result.push(item);
			}

		});

		return result;
	};

});

function InstantSearchController($scope,$http){
  var url = "/api/v1/courses";

  $http.get(url).success( function(response) {
    console.log('success');
    $scope.items = response.courses;
  });
};
