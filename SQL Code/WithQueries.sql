drop database if exists jdbclab4;
CREATE DATABASE IF NOT EXISTS jdbclab4;
USE jdbclab4;

create table Trip (
TripNumber int not null,
StartLocationName varchar(100) not null,
DestinationName varchar(100) not null,
primary key(TripNumber) 
);

create table Driver (
DriverName varchar(100) not null,
DriverTelephoneNumber varchar(100) not null,
primary key (DriverName)
);

create table Bus (
BusID INT not null, 
Model varchar(100),
Year INT,
primary key(BusID) 
);

create table Stop (
StopNumber INT not null,
StopAddress varchar(100) not null,
primary key (StopNumber)
);

create table TripOffering(
TripNumber int not null,
Date date not null,
ScheduledStartTime time not null,
ScheduledArrivalTime time not null,
DriverName varchar(100),
BusID INT,
primary key (TripNumber, Date, ScheduledStartTime),
foreign key (TripNumber) references Trip (TripNumber) on delete cascade on update cascade,
foreign key (DriverName) references Driver (DriverName) on delete set null on update cascade,
foreign key (BusID) references Bus (BusID) on delete set null on update cascade
);

create table TripStopInfo (
TripNumber INT not null,
StopNumber INT not null,
SequenceNumber INT not null,
DrivingTime INT,
primary key (TripNumber, StopNumber),
foreign key (TripNumber) references Trip (TripNumber) on delete cascade on update cascade,
foreign key (StopNumber) references Stop (StopNumber) on delete cascade on update cascade
);

create table ActualTripStopInfo (
TripNumber INT not null,
Date date not null,
ScheduledStartTime time not null,
StopNumber INT not null,
ScheduledArrivalTime time not null,
ActualStartTime time,
ActualArrivalTime time,
NumberOfPassengersIn INT,
NumberOfPassengersOut INT,
primary key(TripNumber, Date, ScheduledStartTime, StopNumber),
foreign key (TripNumber, Date, ScheduledStartTime) references TripOffering (TripNumber, Date, ScheduledStartTime) on delete cascade on update cascade,
foreign key (StopNumber) references Stop (StopNumber) on delete cascade on update cascade
);

insert into Driver (DriverName, DriverTelephoneNumber) values
('Alex Kim', '909-555-0100'),
('Sam Lee',  '909-555-0111'),
('Jordan Park', '909-555-0122'),
('David Carbajal', '951-495-2388');

insert into Bus (BusID, Model, Year) values
(1, 'New Flyer Xcelsior', 2020),
(2, 'Gillig Low Floor',   2019),
(3, 'BYD K9 Electric',    2021);

insert into Trip (TripNumber, StartLocationName, DestinationName) values
(100, 'Pomona', 'Claremont'),
(200, 'Pomona', 'La Verne'),
(300, 'Pomona', 'Montclair');

insert into Stop (StopNumber, StopAddress) values
(10, '1000 S Campus Dr, Pomona, CA'),
(20, '101 First St, Claremont, CA'),
(30, '200 E Arrow Hwy, La Verne, CA'),
(40, '5060 N Montclair Plaza Ln, Montclair, CA');

insert into TripStopInfo (TripNumber, StopNumber, SequenceNumber, DrivingTime) values
(100, 10, 1, 0),   (100, 20, 2, 15),
(200, 10, 1, 0),   (200, 30, 2, 20),
(300, 10, 1, 0),   (300, 40, 2, 25);

insert into TripOffering
(TripNumber, `Date`, ScheduledStartTime, ScheduledArrivalTime, DriverName, BusID) values
(100, '2025-08-11', '08:00:00', '08:15:00', 'Alex Kim', 1),
(100, '2025-08-11', '09:00:00', '09:15:00', 'Sam Lee', 2),
(200, '2025-08-11', '08:30:00', '08:50:00', 'Alex Kim', 2),
(300, '2025-08-11', '10:00:00', '10:25:00', 'Jordan Park', 3),
(100, '2025-08-12', '08:00:00', '08:15:00', 'Alex Kim', 1),
(200, '2025-08-12', '08:30:00', '08:50:00', 'Sam Lee',  3);

insert into ActualTripStopInfo
(TripNumber, `Date`, ScheduledStartTime, StopNumber,
 ScheduledArrivalTime, ActualStartTime, ActualArrivalTime,
 NumberOfPassengersIn, NumberOfPassengersOut) values
(100, '2025-08-11', '08:00:00', 10, '08:00:00', '08:02:00', '08:02:00', 5, 0),
(100, '2025-08-11', '08:00:00', 20, '08:15:00', '08:16:00', '08:17:00', 2, 6),
(200, '2025-08-11', '08:30:00', 10, '08:30:00', '08:31:00', '08:32:00', 3, 0),
(200, '2025-08-11', '08:30:00', 30, '08:50:00', '08:51:00', '08:52:00', 1, 4);

select * from Driver;
select * from Bus;
select * from Trip;
select * from Stop;
select * from TripStopInfo;
select * from TripOffering;
select * from ActualTripStopInfo;

select T.ScheduledStartTime, T.ScheduledArrivalTime, T.DriverName, T.BusID
from TripOffering T, Trip TT
where TT.TripNumber = T.TripNumber
and TT.StartLocationName = 'Pomona'
and TT.DestinationName = 'Claremont';

delete from TripOffering
where TripNumber = 100 and `Date` = '2025-08-11' and ScheduledStartTime = '09:00:00';
select * from TripOffering
where TripNumber = 100 and `Date` = '2025-08-11'
order by ScheduledStartTime;

insert into TripOffering
(TripNumber, `Date`, ScheduledStartTime, ScheduledArrivalTime, DriverName, BusID) values
(100, '2025-08-13', '08:00:00', '08:15:00', 'Alex Kim', 1);
select * from TripOffering;

update TripOffering
set DriverName = 'David Carbajal'
where TripNumber = 100 and `Date` = '2025-08-12' and ScheduledStartTime = '08:00:00';
select * from TripOffering;

update TripOffering
set BusID = 2
where TripNumber = 100 and `Date` = '2025-08-12' and ScheduledStartTime = '08:00:00';
select * from TripOffering;

select TripNumber, StopNumber, SequenceNumber, DrivingTime
from TripStopInfo;

select `Date`, ScheduledStartTime, ScheduledArrivalTime, TripNumber, BusID
from TripOffering
where DriverName = 'Alex Kim'
  and `Date` between '2025-08-11' and date_add('2025-08-11', interval 6 day)
order by `Date`, ScheduledStartTime;

insert into Driver (DriverName, DriverTelephoneNumber)
values ('Taylor Cruz', '909-555-0133');
select * from Driver;

insert into Bus (BusID, Model, Year)
values (4, 'Proterra ZX5', 2022);
select * from Bus;

insert into ActualTripStopInfo
(TripNumber, `Date`, ScheduledStartTime, StopNumber,
 ScheduledArrivalTime, ActualStartTime, ActualArrivalTime,
 NumberOfPassengersIn, NumberOfPassengersOut) values
(100, '2025-08-12', '08:00:00', 10, '08:00:00', '08:01:00', '08:01:00', 4, 0),
(100, '2025-08-12', '08:00:00', 20, '08:15:00', '08:16:00', '08:17:00', 3, 5);
select * from ActualTripStopInfo;
