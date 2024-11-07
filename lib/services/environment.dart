
String apiUrl ="https://api.sadhanasheet.com/v1";
Map<String, String>?  headersToken(token) => {'Accept': 'application/json', 'Content-Type': 'application/json',"Authorization" :"Bearer $token"};

Map<String, String>? get  headers => {'Accept': 'application/json', 'Content-Type': 'application/json'};

// String apiUrl = "https://api.sadhanasheet.com/v1";
//
// Map<String, String>? headersToken(token) => {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       "Authorization":
//           "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGkuc2FkaGFuYXNoZWV0LmNvbSIsImF1ZCI6ImNvbS5zYWRoYW5hcnJlY29yZC5iaGFrdGlzdGVwcyIsImlhdCI6MTcwNzczNzM5NiwiZXhwIjoxNzE0MzAzNzk2LCJ1aWQiOiIzeDVmSnpvdVJPWWdlSWxRU2ZUU3dGRTlubHAxIn0.NQJXMdamPr-MowsHR_eSk_X665AkvQMuhE9lrwOxb9o"
//     };
//
// Map<String, String>? get headers =>
//     {'Accept': 'application/json', 'Content-Type': 'application/json'};
