# AAE6102-Assignment-2-YAN-Xinhao

## Task 1 – Differential GNSS Positioning

A short essay (500–1000 words) comparing the pros and cons of the following GNSS techniques for smartphone navigation: 
Differential GNSS (DGNSS), 
Real-Time Kinematic (RTK), 
Precise Point Positioning (PPP), 
PPP-RTK.

### 1. Differential GNSS (DGNSS)

```matlab
Model: ChatGPT o4-mini
```

DGNSS is a method that applies real-time code‐phase corrections from a near base station to a receiver to reduce the GNSS errors.

#### Pros:

It improves the traditional direct GNSS positioning accuracy to around 0.5–1 m.

It is relatively simple to be implemented.

It has relatively low latency.

#### Cons:

Although it increases the accuracy than basic GNSS, it cannnot provide high accuracy.

Its quality degrades with the increase of the distance.

It cannot solve the multipath.

### 2. Real-Time Kinematic (RTK)

RTK is a technique that uses carrier-phase differential corrections and integer resolution from one or more base stations to deliver the centimeter-level position in real time.

#### Pros:

It can achieve centimeter-level accuracy.

It can provide immediate corrections

#### Cons:

It can only work effectively in a limited range.

It requires continuous, low‐latency communication.

It is also susceptible to multipath.

### 3. Precise Point Positioning (PPP)

PPP is a single‐receiver approach that combines dual‐frequency carrier-phase measurements with precise satellite orbit and clock products to compute the position with decimeter-to-centimeter accuracy after a convergence period.

#### Pros:

It can achieve global coverage without considering the coverage.

It does not require the local base stations.

It can achieve decimeter-level and even centimeter-level accuracy.

#### Cons:

It requires a long convergence time to reach the full accuracy.

Its accuracy is lower than RTK especially for kinemeitc situation.

### 4. PPP-RTK

PPP-RTK is a hybrid service that broadcasts real-time regional or global satellite and atmospheric correction, combining blending PPP and RTK, to achieve rapid convergence to centimeter-level positioning without local base stations.

#### Pros:

It can achieve fast convergence while maintain centimeter‐level accuracy.

It can provide survice across a wide area without the need for dense local base stations.

#### Cons:

The algorithm is very complex.

It requires the continuous broadcast of both the local and global correction streams.

Receiver firmware must implement advanced PPP-RTK algorithms.

<br>

Finally, we give a table to summarize the differences of these methods.

| Method | Differential GNSS (DGNSS) | Real-Time Kinematic (RTK) | Precise Point Positioning (PPP) | PPP-RTK |
| :--- | :--- | :--- | :--- | :--- |
| Coverage | Regional | Local | Global | Global |
| Time Efficiency | Real-Time | Real-Time | Nearly Real-Time | Real-Time |
| Convergence Time | instant | 5~30s | 600~1200s | 5~30s |
| Hardware requirement | Low | High | Moderate | High |
| Observation | Code | Phase, Code | Phase, Code | Phase, Code |
| Correction Information | Observation domain | Observation domain | State-space | State-space |
| Static Positioning Accuracy | 0.5–1m | 1–3cm | ~5cm | 1–3cm |
| Kinematic Positioning Accuracy | 0.5–1m | 1–3cm | 15~20cm | 1–3cm |
| Tropospheric Delay | Corrected in OSR | Eliminated | Estimated | Corrected in OSR |
| Ionospheric Delay | Corrected in OSR | Eliminated | Estimated/Eliminated | Corrected in OSR |





## Task 2 – GNSS in Urban Areas

Call the - navSolutionResults.mat file from "Urban.dat" data generated in A1 to get the information of pseudorange, satellite position, etc.

Analyze the skymask to identify the azimuth and elevation angles where satellite signals are obstructed. After load skymask CSV, we can see the skymask is plotted with azimuth on the x-axis and blocking elevation on the y-axis.

<img width="1482" alt="1745933039441" src="https://github.com/user-attachments/assets/53ce1fdb-31f5-4081-a3ab-ea492b54e7f0" />

Then process the skymask data to adjust the angle, finally obtain it:





## Task 3 – GPS RAIM (Receiver Autonomous Integrity Monitoring)

### 1. Classic weighted RAIM algorithm

The weighted least squares solution for x can be found by

$x=(G^{T}WG)^{-1}G^{T}W$.

where the definition has been made for K (the weighted pseudo-inverse of G) and where W is the inverse of the covariance matrix.

After computing the position using WLS, calculate the residuals for each satellite measurement: 

$\varepsilon=y-Gx=(I-GK)y=(I-P)y$

where the definition has been made

From these error estimates we can define a scalar measure defined as the Weighted Sum of the Squared Errors

$WSSE=\varepsilon^{T}W\varepsilon=((I-P)y)^{T}W(I-P)y$

which is equivalent to

$WSSE=\varepsilon^{T}W\varepsilon=y^{T}W(I-P)y$

The threshold T is chosen such that the probability of false alarm is commensurate with the continuity requirement for precision approach. 
The talbe of the values of threshold T for given probabilities of false alarm and number of satellites is given below.

<img width="712" alt="1745929778043" src="https://github.com/user-attachments/assets/9a4b8507-654f-4e26-b532-7624c7b3db40" />

Compare each test statistic against the threshold. 
If it exceeds the threshold, the measurement is considered faulty.

### 2. Weighted RAIM algorithm for “Open-Sky” data.

We set the file path as the open-sky data and read certain data.

```matlab
filePath = 'C:\Users\yan\Desktop\AAE6102 Satellite Communication and Navigation\Assignment2\PolyU_AAE6102_Assignment2-main\Task3\navSolutions-Opensky.mat';

% Check if the file exists and load data
if exist(filePath, 'file')
    navSolutions1 = load(filePath);  
    pseudoranges = navSolutions1.navSolutions.correctedP; % 5x178 matrix
    satellite_positions = navSolutions1.navSolutions.satPositions; % 3x5x178 matrix
else
    error('File not found: %s', filePath);
end
```

### 3. Ensure your solution effectively detects and excludes the impact of faulty or low-quality measurements.

We apply the RAIM algorithm to detect whether the data is normal.

```matlab
% Compute initial position estimate using WLS
position = (A' * W * A) \ (A' * W * current_pseudoranges);

% Compute residuals
residuals = current_pseudoranges - A * position;

% Compute variance of residuals
sigma_r2 = (residuals' * residuals) / (n - 4);

% Chi-square test for fault detection
chi_square = (residuals' * W * residuals) / sigma_r2;
```

### 4. 3D protection level (PL)

For $P_{fa}=10^{-2}$, we can calculate the threshold directly using the aforementioned statistical tables.

For $P_{md}=10^{-7}$, we can use the threshold $5.33\sigma$.

### 5. Evaluate the GNSS integrity monitoring performance

Compare the computed protection level against the alarm limit (AL) of 50 meters. 
If the protection level exceeds the alarm limit, the system is not reliable.

<img width="1271" alt="1745932959795" src="https://github.com/user-attachments/assets/bef98aef-196d-4ed7-92ed-ac22ce2701dc" />






## Task 4 – LEO Satellites for Navigation

```matlab
Model: ChatGPT o4-mini
```

Low Earth Orbit (LEO) satellites, operating at altitudes between roughly 500 km and 2 000 km, are becoming increasingly popular as platforms for broadband communication (e.g., Starlink, OneWeb). Their relative proximity to Earth offers low-latency, high-capacity data links, but it also creates unique hurdles when these satellites are leveraged for positioning, navigation, and timing (PNT) services. Below, we examine the primary difficulties of repurposing LEO communication constellations for GNSS-style navigation.

### 1. Rapid Orbital Dynamics and Doppler Effects

High angular velocity
A typical LEO satellite completes one orbit in about 90–120 minutes, translating to angular rates of several degrees per minute as seen from a ground receiver. By contrast, Medium Earth Orbit (MEO) GNSS satellites move more slowly across the sky. Rapid motion leads to

Large Doppler shifts (±50 kHz or more at L-band) that fluctuate quickly.
Short-lived satellite visibility windows (often 8–12 minutes per pass), requiring fast acquisition and tracking.
Frequent handovers
Receivers must seamlessly switch lock from one satellite to the next far more often than with MEO GNSS. Handovers impose tight timing and synchronization requirements on both the space and user segments.

### 2. Precise Satellite Orbit and Clock Determination

Orbit accuracy
High-accuracy positioning demands real-time knowledge of each satellite’s orbit to within decimeters. LEO communication fleets typically optimize their on-board telemetry for network routing and beam pointing, not centimeter-level orbit determination. Achieving GNSS-grade orbits requires

Additional on-board GNSS receivers (often dual-frequency) or ground-based tracking.
Frequent upload of precise ephemerides to each satellite.
Clock stability
Civil GNSS satellites carry ultra-stable atomic clocks. Communication LEOs, in contrast, usually employ less stable rubidium or crystal oscillators. Poor on-board clock stability translates directly into pseudorange errors unless

High-rate clock corrections are uplinked continuously.
Inter-satellite links or global networks of ground stations are used to estimate and broadcast corrections.

### 3. Signal Design and Spectrum Constraints

Non-GNSS waveforms
Existing communication payloads are designed for data throughput and may use wideband modulations (QPSK, OFDM) in Ka/Ku bands, not the narrowband BPSK/CBOC signals at L1/L5 used by GPS/Galileo. To embed ranging signals, operators must

Reserve spectrum or pilot channels for navigation.
Design new waveforms that balance data and ranging needs.
Regulatory hurdles
Allocating GNSS-compatible spectrum to commercial constellations requires coordination with the International Telecommunication Union (ITU). Avoiding harmful interference with incumbent GNSS services can be complex and time-consuming.

### 4. Receiver Complexity and Power Constraints

Wide Doppler search
User equipment must scan a broader frequency range at faster rates. Traditional GNSS front-ends handle ±5 kHz Doppler comfortably; LEO PNT receivers must cope with an order of magnitude more, increasing acquisition time and computation.

Tracking loop dynamics
Carrier and code tracking loops must be tuned for higher jerk (rate of change of Doppler), necessitating

Wider loop bandwidths for robustness.
More power consumption and higher-performance signal processors.
Antenna considerations
Some LEO systems use steerable, high-gain or phased-array antennas optimized for downlink data. Repurposing these for omni-directional PNT reception may require hardware modifications, adding size, weight, or cost.

### 5. Geometry, Coverage, and Availability

Temporal and spatial geometry
While a large LEO constellation can provide excellent geometric dilution of precision (GDOP) when many satellites are in view, the ephemeral nature of each satellite pass complicates

Continuous, 24/7 PNT coverage in certain latitudes.
Seamless service in urban canyons or deep valleys, where rapid link dropouts are more frequent.
Constellation maintenance
Frequent orbital adjustments (for collision avoidance or beam re-pointing) can degrade the predictability of satellite positions, requiring real-time updates to maintain navigation accuracy.

### 6. Ground Segment and Operational Costs

Extensive ground infrastructure
Delivering precise ephemerides and clock corrections in real time demands a dense network of monitoring stations and uplink gateways. Building and operating this infrastructure may offset some of the cost advantages of using a commercial communication fleet.

Data latency and integrity
Even small delays in uplinking corrections—whether due to backhaul congestion or processing—translate directly into position errors. Robust, low-latency communication paths are thus paramount.

Conclusion
LEO communication satellites hold great promise as platforms for complementary or even primary PNT services, offering low-latency global coverage and the potential for centimeter-class accuracy. However, the transition from pure communication to dual-use constellations exposes several formidable challenges: managing rapid Doppler and dynamics, achieving GNSS-grade orbit and clock knowledge, embedding ranging signals within existing spectrum allocations, and equipping receivers to handle the increased complexity. Overcoming these obstacles will require close collaboration between satellite operators, regulatory bodies, PNT researchers, and receiver manufacturers. With careful system design and investment in both space- and ground-segment capabilities, LEO-based navigation could one day augment—and even rival—traditional GNSS offerings.





## Task 5 – GNSS Remote Sensing

```matlab
Model: ChatGPT o4-mini
```


