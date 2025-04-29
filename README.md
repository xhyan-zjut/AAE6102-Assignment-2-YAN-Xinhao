# AAE6102-Assignment-2-YAN-Xinhao

## Task 1 – Differential GNSS Positioning

A short essay (500–1000 words) comparing the pros and cons of the following GNSS techniques for smartphone navigation: 
Differential GNSS (DGNSS), 
Real-Time Kinematic (RTK), 
Precise Point Positioning (PPP), 
PPP-RTK.

### 1. Differential GNSS (DGNSS)

#### Pros:

It improves the traditional direct GNSS positioning accuracy to around 0.5–1 m.

It is relatively simple to be implemented.

It has relatively low latency.

#### Cons:

Although it increases the accuracy than basic GNSS, it cannnot provide high accuracy.

Its quality degrades with the increase of the distance.

It cannot solve the multipath.

### 2. Real-Time Kinematic (RTK)

#### Pros:

It can achieve centimeter-level accuracy.

It can provide immediate corrections

#### Cons:

It can only work effectively in a limited range.

It requires continuous, low‐latency communication.

It is also susceptible to multipath.

### 3. Precise Point Positioning (PPP)

#### Pros:

Global coverage—no local reference station needed.

Absolute coordinates in ITRF/ITRS datum.

Decimeter to low‐decimeter (eventually cm) accuracy once converged.

Uses precise satellite orbits & clocks (IGS, commercial streams).

Single receiver solution—ideal for remote/maritime/oceanic applications.

#### Cons:

Long convergence time (10–60 min) to reach full accuracy.

Requires dual-frequency (L1+L2/L5) and phase measurements.

Dependent on precise-product latency (1–30 s) and quality.

Often a subscription service for real-time products.

### 4. PPP-RTK

#### Pros:

Combines PPP’s global datum & network RTK’s rapid convergence.

Fast convergence (tens of seconds) to cm‐level accuracy.

Provides absolute, consistent coordinates across a wide area.

Reduces need for dense local networks—one regional/global service.

Ideal for UAVs, offshore, infrastructure monitoring.

#### Cons:

Requires continuous broadcast of regional/global correction streams.

Service complexity & cost—subscription/licensing for correction data.

Still subject to latency, data link outages, and service availability.

Receiver firmware must implement advanced PPP-RTK algorithms.

Finally, we give a table to summarize the differences of these methods.

| Method | Differential GNSS (DGNSS) | Real-Time Kinematic (RTK) | Precise Point Positioning (PPP) | PPP-RTK |
| :--- | :--- | :--- | :--- | :--- |
| Coverage | Regional (50km) | Local (10km) | Global | Regional/Global |
| Time Efficiency | Real-Time | Real-Time | Nearly Real-Time | Real-Time |
| Convergence Time | instant | 5~30s | 600~1200s | 5~30s |
| Observation | Regional (50km) | Local (10km) | Global | Regional/Global |
| Correction Information | Regional (50km) | Local (10km) | Global | Regional/Global |
| Static Positioning Accuracy | Regional (50km) | Local (10km) | Global | Regional/Global |
| Kinematic Positioning Accuracy | Regional (50km) | Local (10km) | Global | Regional/Global |
| Tropospheric Delay | Regional (50km) | Local (10km) | Global | Regional/Global |
| Ionospheric Delay | Regional (50km) | Local (10km) | Global | Regional/Global |

## Task 2 – GNSS in Urban Areas




## Task 3 – GPS RAIM (Receiver Autonomous Integrity Monitoring)




## Task 4 – LEO Satellites for Navigation



## Task 5 – GNSS Remote Sensing


