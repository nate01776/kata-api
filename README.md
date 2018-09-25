# RBC_katas
## Currently the workshop API is hosted at https://kata-api.herokuapp.com

## Kata_Setup
> Welcome to Smartbear's SoapUI training workshop! We will work through a series of small exercises to uncover some new approachs and solutions within the tool. We will go through a few exercises to get set up with a remote resource, and then experiment with some advanced features and scripting exercises. For our first kata:
- Navigate to http://bitly.com/x
- Bring the composite project into ReadyAPI
  * **Solution_1**: Download and import manually
  * **Ideal_solution**: Use the Git plugin to import directly into ReadyAPI

## Kata_1
### [x] coded
### [x] test_case
### [x] solution_set
> Open test_case_1. The project contains a call to a remote resource. The original creator hard coded the kata number into the path. Make this value dynamic so we can re-use the call across our upcoming test cases and make a request to `/kata/1` to validate

* Solution: Update the request at the project level to include a dynamic path item.

## Kata_2
### [x] coded
### [x] test_case
### [x] solution_set
> Open test_case_2. Update the 'get_kata/key' step to have path `/kata/key` and add query parameter token which is set to 'true'. The service will return a unique key that will be used in the upcoming requests, and will change each time a call is made. Make a second, subsequent request with the same key added as a query parameter 'id' (do not request a token in the second call) to `/kata/2` and run as a sequence. Do not hard code the key value. The service will return a 200 response.
==extra== 
Write an event script to store the key value whenever a request is made to /kata/key

* **Solution_1**: Add query parameter at project level, property Expansion reference to previous response
* **Ideal_solution**: Add query parameter at project level, store, Get Data to project level value.

## Kata_3
### [x] coded
### [x] test_case
### [x] solution_set
> Open test_case_3. Make a key request. Pass this key into the call to `/kata/3`. The service will return one of two responses, a 200 and 500. Create a script which if the service returns a 500, will reiterate over the request a maximum of **5** times until it gets a successful response. Output the number of calls made in the console.

* **Solution_1**: Script step that checks response value from the previous call and returns if incorrect, adds to counter to max of 5

## Kata_4
### [x] coded
### [x] test_case
### [] solution_set -- disable script needs to be written
> Open test_case_4. Make a key request. The second call will return return one of two responses, a 200 or 500. The following 5 requests should be executed if it returns a 200, but anything else all except the last step should be skipped. Output the number of status and message from the final response to the log.

* **Solution_1**: Script step that disables subsequent calls if != 200
* **Ideal_solution**: Script assertion that can handle this

## Kata_5
### [x] coded
### [x] test_case
### [x] solution_set
> Open test_case_5. Make a key request. The call should return an array of objects, different in length each time. Each object should contain UUID, name and location values. Validate that each object contains these - random objects will be malformed. Log each of the 'bad' objects to the console, as well as the number overall in the array.

* **Solution**: Script step to iterate over data
* **Ideal_solution**: JSON Datasource, assertion step inside

## Kata_6
### [x] coded
### [x] test_case
### [x] solution_set
> In the /extras directory of the composite project downloaded earlier, there is an excel data sheet with a number of inputs. These input values should be mapped as values to an POST body object with the following structure:
```
{
  'uuid': 'val',
  'name': 'val',
  'location': 'val'
}
```
> Open test_case_6, make a key request and add a POST body to the `/kata/6` request with the structure above, and iterate over the included data set. Store the response header in the 'results' sheet of the same excel document, along with the uuid from the request. Like the earlier example, some of the input data is malformed and needs to be collected.

* **Solution**: Excel Datasource loop, Datasink as step.

## Kata_7
### [x] image to add
### [x] solution_set
> Each time a test is run in our automation suite, we are expected to output a PDF version of the report. Currently, ReadyAPI is the only brand on the PDF. Update the template with the image include in the /extras directory in the composite project that was accessed through github.

* **Solution**: Update reporting template w/new image.

## Kata_8
### [x] solution_set
> We now have a full test suite of test cases, and a final report format. From a test suite level, find a way to run every test_case with an odd number and generate a report.

* **Solution**: Tag each odd test_case.
