# AAE6102-Assignment-2-YAN-Xinhao

## Task 1 – Differential GNSS Positioning

```matlab
Model: ChatGPT o4-mini
```

### 1. Differential GNSS (DGNSS)

Differential GNSS (DGNSS) is a satellite navigation enhancement technique that employs real-time correction data from a nearby reference or base station. 
The base station, which is located at a precisely surveyed position, continuously calculates the discrepancies between its known coordinates and the GNSS-determined coordinates. 
It then broadcasts these corrections to nearby GNSS receivers, allowing them to reduce common errors such as satellite orbit errors, ionospheric delays, and timing inaccuracies. 
By applying these corrections to the code-phase measurements, DGNSS can significantly improve the positioning accuracy compared to standalone GNSS.

#### Pros:

Improved Accuracy: 
DGNSS increases the positioning accuracy of conventional GNSS systems to approximately 0.5 to 1 meter. 
This improvement is particularly beneficial for applications that require a moderately precise location.

Ease of Implementation: 
The concept behind DGNSS is relatively straightforward. 
Many commercial GNSS receivers come with the capability of receiving differential corrections, making the technology accessible and easy to deploy.

Low Latency: 
Because the correction data is transmitted in real time, DGNSS has a low latency. 
This characteristic is essential for dynamic applications, such as vehicle navigation, where timely updates are crucial.

#### Cons:

Limited Absolute Accuracy: 
While DGNSS significantly improves upon the basic GNSS solution, it may not offer the very high accuracy (i.e., centimeter-level) needed for some precision applications, such as high-precision surveying or autonomous vehicles.

Distance Sensitivity: 
The performance of DGNSS degrades as the distance between the base station and the user-instrument increases. 
Long baselines can introduce additional errors because the atmospheric and ionospheric conditions may differ over larger distances.

Multipath Limitations: 
DGNSS does little to mitigate the effects of multipath interference, where signals reflect off surfaces before reaching the receiver, potentially causing additional positioning errors in challenging environments.

### 2. Real-Time Kinematic (RTK)

Real-Time Kinematic (RTK) is an advanced GNSS positioning technique that employs carrier-phase measurements along with differential corrections to achieve real-time centimeter-level accuracy. 
In RTK, a base station transmits corrections for the carrier-phase ambiguities along with other positional error information to a rover receiver. 
The system resolves the integer ambiguities inherent in the carrier-phase measurements, enabling the precise determination of the rover position in real time.

#### Pros:

Centimeter-Level Accuracy: 
By leveraging the precision of carrier-phase measurements and resolving the integer ambiguity problem, RTK can achieve accuracies on the order of centimeters, making it suitable for applications such as land surveying and precision agriculture.

Immediate Corrections: 
RTK provides immediate, real-time corrections. 
This rapid update rate is vital for dynamic applications, including autonomous navigation and real-time machine control.

#### Cons:

Limited Operational Range: 
RTK’s effectiveness is confined to a relatively short distance from the base station. 
The corrections become less reliable as the baseline increases due to spatial decorrelation of the atmospheric effects.

High Demands for Communication: 
Successful RTK operation requires a continuous, low-latency communication channel between the base station and the rover. 
Any interruption or delay in the communication link can adversely affect the positioning accuracy.

Susceptibility to Multipath: 
Similar to other GNSS enhancement techniques, RTK can be negatively affected by multipath interference, especially in urban or obstructed environments where signal reflections are prevalent.

### 3. Precise Point Positioning (PPP)

Precise Point Positioning (PPP) is an advanced GNSS method that enables accurate positioning using a single receiver without the need for a nearby reference station. 
PPP combines dual-frequency carrier-phase measurements with precise satellite orbit and clock information (often provided by global correction services) to compute the user’s position with high precision. 
It typically takes a convergence period before reaching its highest accuracy, which can range from decimeters to centimeters.

#### Pros:

Global Coverage: 
PPP offers the advantage of global coverage because it relies on precise satellite information rather than using a proximal base station. 
This makes it particularly useful for remote or maritime applications.

No Need for Local Infrastructure: 
Since PPP does not depend on local base stations, it reduces deployment costs and complexity, making it attractive for many scientific and civilian applications.

High Accuracy: 
After the convergence period, PPP can achieve decimeter-level and even centimeter-level accuracies, which are essential for high-precision applications such as geodetic measurements and precise navigation.

#### Cons:

Long Convergence Time: 
One of the major drawbacks of PPP is the convergence period. 
Achieving full accuracy can take anywhere from several minutes to over half an hour, depending on the quality of the GNSS signals and environmental conditions.

Reduced Performance in Dynamic Situations: 
Because PPP relies on a convergence process that assumes relatively stable motion, its accuracy may degrade in high-dynamic scenarios, such as rapid vehicle maneuvers or kinetic tracking applications.

Accuracy Lower than RTK in Certain Conditions: 
Particularly in applications involving rapid movements or short-term tracking, PPP may offer lower accuracy compared to RTK, which is specifically designed for real-time precision.

### 4. PPP-RTK

PPP-RTK is a hybrid GNSS positioning service that integrates the strengths of Precise Point Positioning (PPP) and Real-Time Kinematic (RTK). 
This approach uses a blend of global satellite corrections with local integer ambiguity resolution techniques to achieve rapid convergence and centimeter-level accuracy. 
PPP-RTK systems broadcast real-time regional or global corrections that enable users to benefit from both methods simultaneously without requiring a dense network of local base stations.

#### Pros:

Rapid Convergence: 
PPP-RTK is designed to offer fast convergence times, significantly reducing the waiting period associated with traditional PPP, and quickly achieving centimeter-level accuracy.

Wide Area Coverage: 
Unlike traditional RTK, PPP-RTK can operate over a wide area without relying on a dense network of local base stations, making it an attractive option for large-scale or remote applications.

High Accuracy with Robust Corrections: 
By combining the precise global corrections of PPP with the integer ambiguity resolution methods of RTK, PPP-RTK delivers robust and highly accurate positioning data.

#### Cons:

Algorithm Complexity: 
The hybrid nature of PPP-RTK means that its underlying algorithms are considerably more complex. 
This complexity requires sophisticated processing power and advanced user equipment.

Multiple Correction Streams: 
PPP-RTK systems depend on the continuous broadcast of both local (or regional) and global correction streams. 
Any disruption in these streams can negatively affect positioning performance.

Firmware Demands: 
To take full advantage of PPP-RTK, receivers need to incorporate advanced PPP-RTK algorithms in their firmware. 
This may result in higher costs or the need for specialized receiver technology.

<br>

#### Finally, we give a table to summarize the differences of these methods.

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

Low Earth Orbit (LEO) satellites, operating at altitudes between roughly 500 km and 2 000 km, are becoming increasingly popular as platforms for broadband communication (e.g., Starlink, OneWeb). 
Their relative proximity to Earth offers low-latency, high-capacity data links, but it also creates unique hurdles when these satellites are leveraged for positioning, navigation, and timing (PNT) services. 
Below, we examine the primary difficulties of repurposing LEO communication constellations for GNSS-style navigation.

### 1. Rapid Orbital Dynamics and Doppler Effects

#### High angular velocity
A typical LEO satellite completes one orbit in about 90–120 minutes, translating to angular rates of several degrees per minute as seen from a ground receiver. 
By contrast, Medium Earth Orbit (MEO) GNSS satellites move more slowly across the sky. 

Rapid motion leads to

Large Doppler shifts (±50 kHz or more at L-band) that fluctuate quickly
Short-lived satellite visibility windows (often 8–12 minutes per pass), requiring fast acquisition and tracking.

#### Frequent handovers
Receivers must seamlessly switch lock from one satellite to the next far more often than with MEO GNSS. Handovers impose tight timing and synchronization requirements on both the space and user segments.

### 2. Precise Satellite Orbit and Clock Determination

#### Orbit accuracy
High-accuracy positioning demands real-time knowledge of each satellite’s orbit to within decimeters. 
LEO communication fleets typically optimize their on-board telemetry for network routing and beam pointing, not centimeter-level orbit determination. 
Achieving GNSS-grade orbits requires

Additional on-board GNSS receivers (often dual-frequency) or ground-based tracking.
Frequent upload of precise ephemerides to each satellite.

#### Clock stability
Civil GNSS satellites carry ultra-stable atomic clocks. Communication LEOs, in contrast, usually employ less stable rubidium or crystal oscillators. Poor on-board clock stability translates directly into pseudorange errors unless

High-rate clock corrections are uplinked continuously.
Inter-satellite links or global networks of ground stations are used to estimate and broadcast corrections.

### 3. Signal Design and Spectrum Constraints

#### Non-GNSS waveforms
Existing communication payloads are designed for data throughput and may use wideband modulations (QPSK, OFDM) in Ka/Ku bands, not the narrowband BPSK/CBOC signals at L1/L5 used by GPS/Galileo. 
To embed ranging signals, operators must

Reserve spectrum or pilot channels for navigation.
Design new waveforms that balance data and ranging needs.

#### Regulatory hurdles
Allocating GNSS-compatible spectrum to commercial constellations requires coordination with the International Telecommunication Union (ITU). 
Avoiding harmful interference with incumbent GNSS services can be complex and time-consuming.

### 4. Receiver Complexity and Power Constraints

#### Wide Doppler search
User equipment must scan a broader frequency range at faster rates. 
Traditional GNSS front-ends handle ±5 kHz Doppler comfortably; LEO PNT receivers must cope with an order of magnitude more, increasing acquisition time and computation.

#### Tracking loop dynamics
Carrier and code tracking loops must be tuned for higher jerk (rate of change of Doppler), necessitating

Wider loop bandwidths for robustness.
More power consumption and higher-performance signal processors.

#### Antenna considerations
Some LEO systems use steerable, high-gain or phased-array antennas optimized for downlink data. 
Repurposing these for omni-directional PNT reception may require hardware modifications, adding size, weight, or cost.

### 5. Geometry, Coverage, and Availability

#### Temporal and spatial geometry
While a large LEO constellation can provide excellent geometric dilution of precision (GDOP) when many satellites are in view, the ephemeral nature of each satellite pass complicates

Continuous, 24/7 PNT coverage in certain latitudes.
Seamless service in urban canyons or deep valleys, where rapid link dropouts are more frequent.

#### Constellation maintenance
Frequent orbital adjustments (for collision avoidance or beam re-pointing) can degrade the predictability of satellite positions, requiring real-time updates to maintain navigation accuracy.

### 6. Ground Segment and Operational Costs

#### Extensive ground infrastructure
Delivering precise ephemerides and clock corrections in real time demands a dense network of monitoring stations and uplink gateways. Building and operating this infrastructure may offset some of the cost advantages of using a commercial communication fleet.

#### Data latency and integrity
Even small delays in uplinking corrections—whether due to backhaul congestion or processing—translate directly into position errors. Robust, low-latency communication paths are thus paramount.

#### Conclusion
LEO communication satellites hold great promise as platforms for complementary or even primary PNT services, offering low-latency global coverage and the potential for centimeter-class accuracy. However, the transition from pure communication to dual-use constellations exposes several formidable challenges: managing rapid Doppler and dynamics, achieving GNSS-grade orbit and clock knowledge, embedding ranging signals within existing spectrum allocations, and equipping receivers to handle the increased complexity. Overcoming these obstacles will require close collaboration between satellite operators, regulatory bodies, PNT researchers, and receiver manufacturers. With careful system design and investment in both space- and ground-segment capabilities, LEO-based navigation could one day augment—and even rival—traditional GNSS offerings.





## Task 5 – The impact GNSS Remote Sensing for GNSS Seismology

```matlab
Model: ChatGPT o4-mini
```

Global Navigation Satellite Systems (GNSS), best known for enabling precise positioning and navigation, have transformed the field of seismology by providing direct, high-precision measurements of Earth’s surface displacements during seismic events. 
This fusion of geodesy and seismology—often called GNSS seismology—has revolutionized how we detect, characterize, and respond to earthquakes and related hazards.

### High-Rate GNSS for Dynamic Displacement

Traditional geodetic GNSS operates at low sampling rates (30 s to 5 min), sufficient to monitor slow crustal deformation over months to years. 
In contrast, GNSS seismology leverages high-rate sampling (1 Hz to 20 Hz or more) to record the rapid ground motions produced by earthquakes. 
By tracking the carrier-phase of L1/L2 (or L1/L2/L5) signals with sub-centimeter precision every fraction of a second, GNSS receivers capture:

#### Static offsets: 

Permanent co-seismic displacements of several centimeters to meters.

#### Dynamic waveforms:
Time histories of ground velocity and displacement, complementary to traditional accelerometers and broadband seismometers.
This unique combination of high dynamic range (from millimeters to meters) and absolute accuracy (no need to integrate acceleration) enables direct measurement of both the long-period and permanent components of seismic shaking.

### Applications in Earthquake Monitoring and Early Warning

#### Co-Seismic Displacement Mapping
By differencing pre- and post-quake position time series across a dense network, seismologists can invert for the fault slip distribution and rupture propagation. 
For example, 1 Hz GNSS data during the 2011 Tōhoku earthquake (M9.0) revealed up to 60 m of horizontal displacement near the trench—information crucial for understanding tsunami generation.

#### Real-Time Earthquake Early Warning (EEW)
GNSS seismology complements traditional EEW systems by providing direct, unsaturated measurements of large-magnitude events. 
Software algorithms such as “GNSS-Alert” detect rapid position shifts in real time, allowing magnitude estimates that do not underestimate very large earthquakes (M8+), where seismic magnitudes saturate.

#### Tsunami Warning and Modeling
Static coseismic offsets measured by GNSS feed tsunami models with accurate initial sea-floor displacements. 
This improves forecasted wave heights and arrival times compared to models relying solely on seismic inversion.

#### Structural Health Monitoring
Installed on critical infrastructure—bridges, dams, high-rises—high-rate GNSS receivers detect dynamic deformations during seismic shaking or even ambient vibrations. 
This real-time feedback supports both emergency response and long-term health assessment.

### Advantages Over Conventional Sensors

#### No Saturation: 
Broadband seismometers and accelerometers can either clip during strong shaking or lose sensitivity to very long-period motions. GNSS retains fidelity across a broad frequency band and amplitude range.

#### Absolute Displacement: 
Whereas accelerometers require double integration (compounded drift), GNSS directly measures displacement relative to Earth’s center of mass.

#### Broad Coverage: 
GNSS networks often cover vast regions, including marine installations on buoys or offshore platforms—areas where deploying seismometers is challenging.

### Technical Challenges

#### Signal Noise and Multipath
High-rate positioning is more susceptible to multipath, antenna phase-center variations, and atmospheric delays. 
Mitigation strategies include multi-constellation tracking (GPS, GLONASS, Galileo, BeiDou), choke-ring antennas, and advanced filtering.

#### Real-Time Data Processing
Delivering low-latency (<1 s) displacement estimates over dense networks demands robust telemetry (satellite or cellular) and computational infrastructure capable of precise point positioning (PPP) or network processing with ambiguity resolution.

#### Integration with Seismic Networks
Seamlessly fusing GNSS and seismic data streams requires common time bases, data formats, and algorithms that optimally combine continuous high-frequency GNSS displacements with acceleration waveforms.

#### Cost and Maintenance
High-rate GNSS stations, especially in remote or offshore environments, require reliable power, communications, and regular calibration—posing logistical and financial hurdles.

### Future Directions

#### Multi-GNSS and Multi-Frequency Receivers
By exploiting signals from all available constellations and frequencies, noise is reduced and reliability improves, especially in urban or vegetated settings.

#### Dense, Low-Cost Networks
Emerging cost-effective, single-frequency GNSS receivers—when networked and processed with real-time kinematic (RTK) or PPP-RTK corrections—could fill spatial gaps and create ultra-dense seismic GNSS arrays.

#### Machine Learning for Event Detection
AI algorithms trained on combined GNSS and seismic signatures may detect and classify seismic events more rapidly and accurately, enhancing EEW performance.

#### Integration with Other Geodetic Sensors
Combining GNSS with InSAR, strainmeters, tiltmeters, and LiDAR offers a multi-scale, multi-parameter view of crustal deformation—from the seismic to the interseismic regimes.

### Conclusion
GNSS seismology represents a powerful convergence of positioning technology and earthquake science, offering direct, absolute measurements of both dynamic and static ground motions. Its ability to overcome the limitations of traditional seismometers—especially for very large earthquakes and permanent offsets—has already improved our understanding of seismic sources, enhanced tsunami warnings, and opened new pathways for infrastructure monitoring. While challenges in noise mitigation, real-time processing, and network deployment remain, ongoing advances in GNSS hardware, processing algorithms, and data integration promise to make GNSS an indispensable tool in the seismologist’s arsenal.



