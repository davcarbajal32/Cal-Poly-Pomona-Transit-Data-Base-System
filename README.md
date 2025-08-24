# Cal-Poly-Pomona-Transit-Data-Base-System
Description:
Designed and implemented a database system in MySQL to model a university transit system, including routes, stops, buses, and schedules. Built normalized relational schemas, defined primary/foreign keys, and wrote SQL queries to manage operations such as route assignments, schedule updates, and capacity tracking. Currently extending the project by connecting the database system to Python for advanced querying, automation, and integration with data analysis workflows.

Goal of the project is to make the system do the following:

-Display the schedule of all trips for a given start location, destination, and date, including start time, arrival time, driver, and bus.
  
-Edit the schedule (TripOffering table):
  
-Delete a trip offering (by Trip#, Date, and ScheduledStartTime

-Add trip offerings (with all attributes provided).

-Change the driver for a trip offering.

-Change the bus for a trip offering.

-Display the stops of a given trip (TripStopInfo).

-Display the weekly schedule of a given driver.

-Add a driver or bus.

-Delete a bus.

-Record the actual trip data (ActualTripStopInfo) for a given trip offering

Technologies Used:

MySQL / SQL → Designed relational schema, queries, and transactions.

Python (in progress) → Building integration for database connectivity, querying, and analysis.

Conclusions:
This project demonstrates practical database design and the ability to extend relational systems into Python applications for data-driven decision making and future scalability.
