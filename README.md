## Background Information:
One integral part of our system is the ability to deal with Hubs. A hub can be an Ocean Port, an
Airport, a Railyard, or even a Truck-Terminal. When you combine two hubs, we call that a
Route. We then attach Pricings to these routes, but also to single hubs (local charges at ports
for example). Usually, these pricings are handled in large Excel sheets.
In order to uniquely identify a hub, when we attach a pricing to it, we use the so called
“UN/LOCODE”. The UN constantly updates the LOCODES. A complete version of the list can
be downloaded here: https://www.unece.org/cefact/codesfortrade/codes_index.html.

## Task:
Write a program that:
- Downloads the CSV data (comes as zip file in 3 parts)
- Loads the data into a well designed DB
- Lets a user search through the DB in a web application as well as filtering / sorting it. If
there are no results, display a nice message. There is explicitly no CSS styling needed!
- Lets a user enter any address and find the nearest hub to that (the coordinates are
included in the data, but may need to be converted into a standard lat/lon format)
- Bonus: Button next to search entries that lets you display the hub on a map
