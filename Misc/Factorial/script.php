<?php
    
/***** INFO *****/

$newVariable = "this be a new v yo";

/****************************
PHP Script
for Qualtrics:
1. Retrieve values from table privided,
2. Generate randomized Array,
3. Transform Array into JSON,
4. Return!
****************************/

/****************************
Example JSON printed (and returned?)
{"Flavor":["Vanilla","Chocolate","Vanilla","Vanilla","Chocolate","Chocolate"],
"Mix":["Fresh Fruit","Cookie Crumbs","Brownies","Cookie Crumbs","Brownies","Fresh Fruit"],
"Size":["1 Scoop ($1.50)","3 Scoops ($4.00)","3 Scoops ($4.00)","2 Scoops ($3.00)","1 Scoop ($1.50)","2 Scoops ($3.00)"],
"U_ID":2962}
****************************/

/****************************
Special PHP functions:
- rand(a,b) --> random value from a to b (including both a and b)
- ...
****************************/



/***** DIMENSIONS AND VALUES, NUMBER OF TABLES *****/
#Determine which dimensions we are working with through GET (URL)
if (isset($_GET['dimensions']) and (($_GET['dimensions']) == 1 or ($_GET['dimensions']) == 2)) {
    $values = $_GET['dimensions'];
    }
elseif (isset($_GET['dimensions']) and (($_GET['dimensions']) != 1 and ($_GET['dimensions']) != 2)) {
    $errorString = 'Dimension-table not found! Right now only dimensions1 and dimensions2 exist.';
    error($errorString);
}
else {
    $errorString = 'No dimension table chosen in the URL (for example: ?dimensions=1 or ?dimensions=1)!';
    error($errorString);
}

#Get dimensions and values from external file values.php
$path = 'values' . $values . '.php';
include $path;


/***** USER ID *****/
#Try to ge U_ID from the URL through the GET method
if (isset($_GET['id'])) {
    $id = $_GET['id'];
}
else {
    $id = 0;
}



/***** FUNCTIONS *****/

#Function to randomly choose one value out of a provided number
function random($numberOfValues) {
    $randomNumber = rand(1,$numberOfValues - 1);
    return $randomNumber;
}

#Applying random() to the values of one array (=dimension)
function randomValue($array) {
    $numberOfValues = count($array);
    $randomValue = random($numberOfValues);
    return $randomValue;
}

#Generating new array with 4 randomly chosen values (for 4 questions) of one dimension
function newArray($array) {
    $i = 0;
    global $numberOfTables;
    while ($i < $numberOfTables) {
        $randomValueArray = randomValue($array);
        $newArray[$i] = $array[$randomValueArray];
        $i++;
    }
    return $newArray;
}

    
#Generating new multi-dimensional array for all dimensions
function completeArray($dimensions) {
    $numberOfDimensions = count($dimensions);
    $i = 0;
    while ($i < $numberOfDimensions) {
        $completeArray[$i] = newArray($dimensions[$i]);
        $i++;
    }
    return $completeArray;
}

#Putting the real key value (name of dimension) into the array plus user-id
function finalArray($dimensions) {
    $completeArray = completeArray($dimensions);
    $numberOfDimensions = count($dimensions);
    global $id;
    
    $i = 0;
    while ($i < $numberOfDimensions) {
        $keyName = $dimensions[$i][0];
        $finalArray[$keyName] = $completeArray[$i];
        $i++;
    }
    
    $finalArray['U_ID'] = $id; //where do we get this value?
    
    return $finalArray;
}

#Transofrming Array into JSON
function transform($dimensions) {
    $finalArray = finalArray($dimensions);
    $finalJson = json_encode($finalArray);
    return $finalJson;
}

#Returning the JSON in the end
#(Or do we have to print it?)
function finalJson($dimensions) {
    $finalJson = transform($dimensions);
    return $finalJson;
}

#Error Function to handle errors
function error($errorMessage) {
    echo $errorMessage;
    exit;
}

/***** OUTPUT *****/
print finalJson($dimensions);

?>
