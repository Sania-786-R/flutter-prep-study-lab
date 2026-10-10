import 'package:prep_study_lab/models/models.dart';

final List<Map<String, dynamic>> rawInitialCourses = [
  {
    "id": "course-iiot-cps-master",
    "code": "IIOT-CPS-101",
    "name": "Industrial IoT 4.0 and Cyber Physical Systems",
    "description": "Comprehensive Question Bank covering Industrial IoT, Smart Manufacturing, and Cyber-Physical Systems.",
    "totalQuestions": 150,
    "weeks": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11
    ],
    "status": "published",
    "sourcePdfName": "nptl 6 weeks.pdf",
    "createdAt": "2026-09-18T10:00:00.000Z",
    "publishedAt": "2026-09-18T10:00:00.000Z"
  }
];

final List<Map<String, dynamic>> rawInitialQuestions = [
  {
    "id": "q-iiot-w1-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 1,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which sensor can detect gases like LPG, CH4, and CO?",
    "options": [
      "DHT22",
      "MQ-5",
      "HC-SR04",
      "PIR"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.928Z"
  },
  {
    "id": "q-iiot-w1-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 2,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which modulation scheme does Zigbee use for the 2.4 GHz band?",
    "options": [
      "BPSK",
      "QPSK",
      "OQPSK",
      "FSK"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 3,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What does the Constrained RESTful Environments (CoRE) framework include for service discovery?",
    "options": [
      "Registration Interface (RI)",
      "Resource Directory (RD)",
      "REST based protocols such as HTTP and CoAP",
      "All of the above"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 4,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is the maximum data rate of Z-Wave communication technology?",
    "options": [
      "100 kbps",
      "250 kbps",
      "500 kbps",
      "1 Mbps"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 5,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which protocol is CoAP based on?",
    "options": [
      "TCP",
      "FTP",
      "UDP",
      "HTTP"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 6,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which coding scheme is used by the IEEE 802.15.4 standard for transmitting information?",
    "options": [
      "CSS",
      "THSS",
      "OFDM",
      "DSSS"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 7,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What does 'Range' indicate in a sensor?",
    "options": [
      "The correctness of the output",
      "The smallest change in input that can be detected",
      "The difference between the standard value and the value produced by the sensor",
      "The highest and the lowest value of the physical quantity within which the sensor can actually sense"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 8,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which organization has developed the ISA 100.11a standard?",
    "options": [
      "Instrument Society of America",
      "International Society of Automation",
      "International Studies Association",
      "International Solar Alliance"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 9,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is/are the drawbacks of proprietary non-IP-based solutions?",
    "options": [
      "Limited flexibility to end users",
      "Interoperability",
      "Limited last-mile connectivity",
      "All of these"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 10,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which MQTT QoS Level is also known as \"at most once\" delivery?",
    "options": [
      "QoS 0",
      "QoS 1",
      "QoS 2",
      "None of these"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 11,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Fill in the blank space designated by the question mark.",
    "options": [
      "Snubber",
      "Repeater",
      "Processor",
      "Amplifier"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 12,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following best describes a vector sensor?",
    "options": [
      "Its response depends only on the temperature.",
      "Its response depends only on the magnitude of the input.",
      "Its response depends on the magnitude, direction, and orientation of the input parameter.",
      "Its response is independent of the input parameter."
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 13,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following frequency ranges is used by 6LoWPAN worldwide?",
    "options": [
      "902–929 MHz",
      "2400–2483.5 MHz",
      "1800–1900 MHz",
      "5.8 GHz"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 14,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In DDS RTPS, data is referred to as:",
    "options": [
      "Packets",
      "Frames",
      "Messages",
      "Topics"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w1-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 1,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 15,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following IoT protocols is based on the session layer of the OSI model?",
    "options": [
      "MQTT",
      "CoAP",
      "AMQP",
      "DTLS"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 16,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is a significant characteristic of new materials in the context of the Fourth Industrial Revolution?",
    "options": [
      "High cost and scarcity",
      "Lighter, stronger, recyclable, and adaptive",
      "Easily available but very expensive",
      "Non-recyclable and heavy"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 17,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is NOT a characteristic of the Fourth Industrial Revolution?",
    "options": [
      "Extensive use of the ubiquitous and mobile internet",
      "Use of artificial intelligence and machine learning",
      "Invention of the steam engine",
      "Development of Cyber Physical Systems (CPS)"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 18,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is considered the main nervous system of any manufacturing industry?",
    "options": [
      "Human Resources",
      "Information and Communication Technology (ICT)",
      "Supply Chain Management (SCM)",
      "Marketing"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 19,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is not a characteristic of a sustainable industry?",
    "options": [
      "Energy efficiency",
      "Reliance on government subsidy",
      "Conservation of resource",
      "Low-waste production"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 20,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What does L, D and T stand for under 'People Engagement' in the Lean production System?",
    "options": [
      "Learn, Do, Teach",
      "Leverage, Divulge, Teardown",
      "Lean, Diverse, Timid",
      "Loan, Deploy, Test"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 21,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which resource is associated with the 'Optimization' categorization of Smart and connected products?",
    "options": [
      "Optimization algorithms",
      "Manual controls",
      "Marketing data",
      "Financial reports"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 22,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "State True or False. The amalgamation of CPS and the evolution of Internet-based technologies led to the development of the Industrial Internet.",
    "options": [
      "True",
      "False",
      "Cannot be determined",
      "None of the above"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 23,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "State True or False. Real-time supply chain monitoring reduces inventory and capital requirements.",
    "options": [
      "True",
      "False",
      "Cannot be determined",
      "None of the above"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 24,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the context of Industry 4.0, what is the full form of CPS?",
    "options": [
      "Controlled Power System",
      "Customer Provisioning Service",
      "Cloud Processing Service",
      "Cyber Physical Systems"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 25,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What does ERP stand for in the context of ICT?",
    "options": [
      "Enterprise Resource Planning",
      "Electronic Resource Platform",
      "Enhanced Reporting Protocol",
      "Economic Resource Planning"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 26,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is a 'value stream' in Lean Production System?",
    "options": [
      "A set of tools for production",
      "All the actions required for a product from order to delivery",
      "A method of employee training",
      "A type of waste reduction"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 27,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following are key attributes of a smart business model?",
    "options": [
      "Manual processes, cost reduction, and labor dependency",
      "Value proposition, revenue streams, and technologies",
      "Traditional marketing, fixed costs, and limited innovation",
      "Centralized control, non-digital strategies, and fixed processes"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 28,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is not a component of a Smart Factory?",
    "options": [
      "Smart machines",
      "Smart manufacturing processes",
      "Information Technology",
      "Physical ledgers"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 29,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In which format is healthcare data transmitted to maintain data uniformity and interoperability?",
    "options": [
      "HL-7",
      "LH-5",
      "HD-7",
      "None of these"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w2-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 2,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 30,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What are the key characteristics of agility?",
    "options": [
      "Stability, Rigidity, and Standardization",
      "Flexibility, Adaptation, and Self-configuration",
      "Planning, Controlling, and Monitoring",
      "Automation, Documentation, and Testing"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 31,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What does \"reactive computation\" in CPS signify?",
    "options": [
      "Systems with zero response time",
      "Interaction with the environment in an ongoing manner",
      "Predefined computation processes",
      "Complete isolation from physical feedback"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 32,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Fill in the blanks. In healthcare applications, CPS is used for __________.",
    "options": [
      "Image-guided surgery and therapy",
      "Manual monitoring of vitals",
      "Static hospital management systems",
      "Front desk management"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 33,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which level in the \"5C Architecture\" ensures the gathering of precise status information of machines?",
    "options": [
      "Conversion",
      "Cognition",
      "Cyber",
      "Configuration"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 34,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Fill in the blanks. Intelligent sensors are capable of __________.",
    "options": [
      "Only sensing data",
      "Processing sensed data and managing external sensors/devices",
      "Limited communication",
      "Basic analog-to-digital conversion"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 35,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "How many steps are there in the PLM solution approach in Industry 4.0?",
    "options": [
      "10",
      "12",
      "8",
      "7"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 36,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is not a key component of an AR Device?",
    "options": [
      "Sensors",
      "Cameras",
      "Projection Screen",
      "Remote Control"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 37,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is NOT a challenge of AI in IIoT?",
    "options": [
      "Connecting devices",
      "Understanding data",
      "Training AI models",
      "Lack of available data"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 38,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is not one of the primary constraints of mobile CPS?",
    "options": [
      "Stability of the network",
      "Power requirement",
      "Security",
      "Design aesthetics"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 39,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What are the components of the 5C architecture for CPS?",
    "options": [
      "Connection, Conversion, Cyber, Cognition, Configuration",
      "Creation, Controlling, Continuation, Convergence, Compatibility",
      "Calculation, Catalysis, Convergence, Convenience, Cognizance",
      "None of these"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 40,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is one of the key features of CPS in terms of computation?",
    "options": [
      "Static computation",
      "Reactive computation",
      "Limited computation",
      "Redundant computation"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 41,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is a collaboration platform in the context of Industry 4.0?",
    "options": [
      "A type of business software that combines organizational networking capacities with operations",
      "A social media platform for employees",
      "A traditional project management tool",
      "A financial management system"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 42,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is a key feature of Augmented Reality (AR)?",
    "options": [
      "Completely replacing the physical environment",
      "Enhancing the present perception of reality",
      "Only providing auditory feedback",
      "Operating in isolated systems"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 43,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Who proposed the first use of the phrase \"Artificial Intelligence\"?",
    "options": [
      "Alan Turing",
      "John McCarthy",
      "Marvin Minsky",
      "Herbert Simon"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 44,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following statements is true?",
    "options": [
      "A program without AI uses a large knowledge base and a heuristic search method",
      "A program with AI uses a large database and an algorithmic search method",
      "A program with AI uses a large knowledge base and a heuristic search method",
      "A program without AI uses a large database and a heuristic search method"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w3-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 3,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 45,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following are constraints of mobile CPS?",
    "options": [
      "Network stability",
      "Power requirement",
      "Security",
      "All of the above"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 46,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What does Application Security aim to protect against?",
    "options": [
      "Unauthorized physical access",
      "Threats to the software applications",
      "Data breaches from the internet",
      "Network architecture issues"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 47,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is Ransomware?",
    "options": [
      "A type of malware that provides a facility to the attacker to lock users' computer files by using encryption and demand money to unlock them",
      "A program that increases computer performance",
      "A system to enhance network speed",
      "A method to secure data from unauthorized access"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 48,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is a major challenge in the deployment of IIoT?",
    "options": [
      "Legacy installations",
      "Cybersecurity",
      "Lack of standardization",
      "All of the above"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 49,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What are the three waves of industrial level innovation according to GE?",
    "options": [
      "The Internet Revolution, The Digital Revolution, The Industrial Internet",
      "The Industrial Revolution, The Internet Revolution, The Industrial Internet",
      "The Agricultural Revolution, The Internet Revolution, The Industrial Internet",
      "The Scientific Revolution, The Industrial Revolution, The Internet Revolution"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 50,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is a major drawback of the Industrial Revolution?",
    "options": [
      "It had no impact on the environment",
      "It created a bad working environment and inefficient processes",
      "It reduced the use of fossil fuels",
      "It enhanced the quality of life for all workers"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 51,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which component is NOT part of the configurations involved in smart sensors?",
    "options": [
      "Multiparameter Sensing Unit",
      "Analog Detection Circuit",
      "Digital Signal Conditioning Unit",
      "Manual Control Unit"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 52,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which sector is predicted to have the highest growth in Industry 4.0?",
    "options": [
      "Electronics",
      "Manufacturing",
      "Defense",
      "Automotive"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 53,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is the focus of the 'Control Layer' in the 5C Architecture for Cyber Physical Systems?",
    "options": [
      "Data collection",
      "Sensor-based monitoring",
      "Supervised control: Self-configure, Self-optimize, Self-adjust",
      "Human-readable interpretation and data visualization"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 54,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Why are IIoT Security Standards required, especially when diverse systems and equipment are integrated on a smart factory floor?",
    "options": [
      "To reduce the cost of implementing IIoT.",
      "Because leaving security to individual IIoT implementers is dangerous and every weak line puts the whole factory at risk.",
      "To ensure that only new systems are implemented, not legacy ones.",
      "To increase the complexity of the smart factory floor."
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 55,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the mining industry, how do sensor networks with gas sensors, strata monitoring devices, and RFID tags contribute to safety and efficiency?",
    "options": [
      "They only help in tracking miners' locations.",
      "They are primarily used for communication between miners.",
      "They replace the need for human inspection.",
      "They provide early disaster warning, monitor working conditions, and help locate miners."
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 56,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Who coined the term \"Industrial Internet\"?",
    "options": [
      "IBM",
      "General Electric (GE)",
      "Intel",
      "Siemens"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 57,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In a milk packaging unit, how is flow measured?",
    "options": [
      "Using a thermometer",
      "Via a spinning impeller that sends signals when milk flows",
      "With a smart camera",
      "Using a GPS module"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 58,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which component is responsible for converting analog data to digital data in a smart sensor node?",
    "options": [
      "Processor",
      "Memory",
      "ADC",
      "DAC"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 59,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Fill in the blanks. Thames Water's smart water management system, as an example of Industrial Process 4.0 operation efficiency, primarily benefits from __________________.",
    "options": [
      "Data monetization and pay-per-use models.",
      "Sensor-based equipment status monitoring and failure detection.",
      "Augmented Reality-based problem diagnosis.",
      "Controlled power generation using weather forecasts."
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w4-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 4,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 60,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "State true or false. In the case of spear phishing, the attackers send thousands of deceitful emails that resemble actual emails from credible sources, while email phishing attacks are targeted at a specific person or organization to obtain sensitive information.",
    "options": [
      "True",
      "False",
      "Cannot be determined",
      "None of the above"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 61,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which company employs the \"Air-as-a-Service\" model by using sensor-equipped air compressors where users pay per cubic meter of air?",
    "options": [
      "John Deere",
      "Kaeser Kompressoren",
      "Magna Steyr",
      "Gehring"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 62,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the context of the Hitachi integrated IIoT platform, what is the name of the core IoT platform used for AI-powered advanced analytics?",
    "options": [
      "Predix",
      "MindSphere",
      "Lumada",
      "Connext"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 63,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the context of Smart Logistics, which company uses IoT and analytics to remotely monitor and optimize fuel consumption for refrigerated and dry cargo containers?",
    "options": [
      "Boeing",
      "Maersk",
      "Komatsu",
      "Stanley Black & Decker"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 64,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the building blocks of a business model, which of the following represents a quantitative value proposition?",
    "options": [
      "Design",
      "Brand perception",
      "Customer experience",
      "Post-purchase cost reduction"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 65,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which IoT business model enables businesses to virtually consolidate and share their IoT-enabled assets among multiple customers to minimize downtime and maximize utilization?",
    "options": [
      "Subscription Model",
      "Asset-Sharing Model",
      "Outcome-Based Model",
      "IoT-as-a-Service"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 66,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In a Cloud-Based Business Model, which offering provides development-oriented platforms to facilitate the integration of applications into existing solutions?",
    "options": [
      "Software-as-a-Service (SaaS)",
      "Infrastructure-as-a-Service (IaaS)",
      "Platform-as-a-Service (PaaS)",
      "Network-as-a-Service (NaaS)"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 67,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the functional flow of IIoT business models, which model specifically employs Cloud-based business models to gather data, analyze it, and sell it as a service?",
    "options": [
      "Service-Oriented Business Model",
      "Process-Oriented Business Model",
      "Product-Oriented Business Model",
      "Asset-Sharing Business Model"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 68,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is considered a lagging Key Performance Indicator (KPI) for Occupational Safety and Health (OSH)?",
    "options": [
      "Frequency of observed unsafe behavior",
      "Number of OSH audits",
      "Percentage of workers with adequate OSH training",
      "Number of fatalities"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 69,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "According to the Industrial Internet Consortium (IIC), what is the primary purpose of their developed testbeds?",
    "options": [
      "To initiate, conceptualize, and rigorously test innovations before market launch",
      "To handle manual data entries for traditional factories",
      "To increase the processing downtime in manufacturing sectors",
      "To establish isolated machine operations away from the cloud"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 70,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the Business Viewpoint of the IIRA framework, what provides the logic regarding the merit of the vision and is validated by stakeholders?",
    "options": [
      "Key Objectives",
      "Fundamental Capabilities",
      "Values",
      "System Requirements"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 71,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the Usage Viewpoint of the IIRA framework, what describes the state of the IIoT system after the successful completion of an activity?",
    "options": [
      "Trigger",
      "Workflow",
      "Constraints",
      "Effect"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 72,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which functional domain in the IIRA functional viewpoint represents the set of functions responsible for the provisioning, deployment, and management of assets?",
    "options": [
      "Control domain",
      "Operations domain",
      "Information domain",
      "Application domain"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 73,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "An IIoT system architect is designing a framework that requires the semantic transformation of assembled data and the subsequent implementation of specific rules to realize a targeted business function. According to the IIRA Functional Viewpoint, which two domains are specifically responsible for handling these respective requirements?",
    "options": [
      "Information domain and Application domain",
      "Operations domain and Business domain",
      "Information domain and Business domain",
      "Application domain and Control domain"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 75,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is NOT categorized as one of the fundamental activities in a business model?",
    "options": [
      "Production",
      "Problem-solving",
      "Platform management",
      "Philanthropy"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w5-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 5,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 76,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the context of IIoT business models, what is the term used for the mechanism by which a service provider transforms the present value of assets into ones with financial value?",
    "options": [
      "Value Proposition",
      "Value Network",
      "Value Capturing Mechanism",
      "Value Communication"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 77,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is highlighted as a benefit of sensor usage in industrial applications for improving overall operations?",
    "options": [
      "Improving visibility",
      "Increasing manual inspection",
      "Enhancing latency",
      "Reducing production rate"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 78,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which type of sensor is primarily used for the inspection of steel pipes and detecting time-varying stresses or strains in ferromagnetic materials?",
    "options": [
      "Torque sensor",
      "Vacuum sensor",
      "Magnetostrictive sensor",
      "Image sensor"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 79,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "The DS1621 temperature sensor is a digital sensor that communicates via an I2C bus and generates temperature data of how many bits?",
    "options": [
      "8 bits",
      "32 bits",
      "16 bits",
      "9 bits"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 80,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In the context of gas sensor characteristics, how is \"Selectivity\" defined?",
    "options": [
      "The ability to detect a particular gas in a mixture of different gases",
      "The time taken to stabilize its response",
      "The change in output signal with respect to unit change in input",
      "The ability to return to its base resistance value"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 81,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What happens to the resistance of an n-type metal oxide semiconductor (MOS) gas sensor when it is exposed to a reducing gas?",
    "options": [
      "It remains unchanged",
      "It increases",
      "It decreases",
      "It fluctuates randomly"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 82,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "How many active connections or sockets does the ModBus-TCP protocol typically support at one time?",
    "options": [
      "Up to 5",
      "Up to 10",
      "Up to 64",
      "Up to 254"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 83,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In EtherNet/IP, which primary type of communication is used to handle real-time I/O data through continuous message transfer?",
    "options": [
      "Implicit",
      "Explicit",
      "Acyclic",
      "Asynchronous"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 84,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Time-Sensitive Networking (TSN) is an extension of Ethernet developed to enable deterministic communication. Which IEEE standard is it primarily based on?",
    "options": [
      "IEEE 802.15.4",
      "IEEE 802.1Q",
      "IEEE 802.1F",
      "IEEE 802.1P"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 85,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "In a Profibus DP (Decentralized Peripherals) network, how many devices are supported at a single time without the use of repeaters?",
    "options": [
      "10",
      "128",
      "64",
      "32"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 86,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "What is the global operating frequency utilized by the CC-Link communication protocol?",
    "options": [
      "2.4 GHz",
      "5.0 GHz",
      "13.56 MHz",
      "433 MHz"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 87,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "The DeviceNet communication protocol links industrial sensors and actuators with Programmable Logic Controllers (PLCs) and is based on which standard?",
    "options": [
      "CAN (Controller Area Network)",
      "IEC 61158",
      "IEEE 802.3",
      "WIA-PA"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 88,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is an advantage of the WIA-PA (Wireless Networks for Industrial Automation-Process Automation) standard?",
    "options": [
      "It operates exclusively on wired fiber optics",
      "It supports Adaptive Frequency Hopping (AFH)",
      "It removes the need for data packet aggregation",
      "It replaces satellite communication"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 89,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "For Ultra-Reliable Low Latency Communication (URLLC) in 5G, what is the specified target for availability?",
    "options": [
      "3-Nines (99.9%)",
      "4-Nines (99.99%)",
      "5-Nines (99.999%)",
      "6-Nines (99.9999%)"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 90,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is an objective of Device-to-Device (D2D) Communication in cellular networks?",
    "options": [
      "Increasing the load on the core network",
      "Eliminating the load on the core network",
      "Maximizing propagation delay",
      "Restricting communication to wired endpoints"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w6-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 6,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 91,
    "sourcePdfName": "nptl 6 weeks.pdf",
    "questionText": "Which of the following is considered a primary disadvantage of millimeter-wave (mmWave) communication?",
    "options": [
      "It requires huge antenna element sizes",
      "It utilizes the heavily congested GHz band",
      "It suffers from high penetration loss and shadowing",
      "It provides very low data throughput"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "createdAt": "2026-09-18T13:48:36.933Z"
  },
  {
    "id": "q-iiot-w7-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 95,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Which modulation technique is incorporated by LoRa technology?",
    "options": [
      "Frequency Shift Keying (FSK)",
      "Phase Shift Keying (PSK)",
      "Chirp Spread Spectrum (CSS)",
      "Amplitude Shift Keying (ASK)"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "LoRa incorporates Chirp Spread Spectrum (CSS) modulation, which uses wideband linear frequency modulated chirp pulses.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 96,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "What is the maximum wireless throughput achieved by the SIGFOX network?",
    "options": [
      "Up to 100 bits per second",
      "Up to 100 bytes per second",
      "Up to 140 bits per second",
      "Up to 1000 bits per second"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "SIGFOX achieves maximum wireless throughput of up to 100 bits per second.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 97,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Depending on the device variant, what is the typical communication range for a Zigbee network?",
    "options": [
      "1 to 5 meters",
      "10 to 100 meters",
      "500 to 1000 meters",
      "1 to 10 kilometers"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Zigbee networks typically operate over a communication range of 10 to 100 meters.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 98,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "In a Zigbee network, which device is specifically responsible for relaying information to other nodes and can also run small-scale applications?",
    "options": [
      "Coordinator",
      "End device",
      "Gateway",
      "Router"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "A Router relays information to other nodes and can run small-scale applications.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 99,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Which software is used to discover and configure Xbee modules before utilizing them for communication?",
    "options": [
      "XCTU",
      "Arduino IDE",
      "NodeMCU Flasher",
      "PuTTY"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "XCTU is the configuration software used to discover and configure Xbee RF modules.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 100,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Which type of IIoT analytics primarily focuses on answering the questions \"What already happened and currently happening\" using dashboards and reports?",
    "options": [
      "Predictive Analytics",
      "Prescriptive Analytics",
      "Descriptive Analytics",
      "Diagnostic Analytics"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Descriptive Analytics primarily focuses on answering \"What already happened and currently happening\" using dashboards and reports.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 101,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Many middleware solutions in IIoT processing architectures are based on which of the following?",
    "options": [
      "Service-Oriented Architecture (SOA)",
      "Microservices Architecture",
      "Monolithic Architecture",
      "Layered Databus Architecture"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Many middleware solutions in IIoT processing architectures are based on Service-Oriented Architecture (SOA).",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 102,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "In the FarmBeats architecture, which component incorporates weather-aware decisions and UAV flight planning?",
    "options": [
      "IoT Base Station",
      "Cloud-Services",
      "Network of Soil Sensors",
      "IoT Gateway"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "In the FarmBeats architecture, the IoT Gateway incorporates weather-aware decisions and UAV flight planning.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 103,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "In the AR Drones-based Precision Agriculture system, what is the specific role of the video processing module deployed in the laptop?",
    "options": [
      "To control the flight path of the UAV remotely",
      "To detect the weeds and generate coordinates",
      "To actuate the precision sprayer directly via Bluetooth",
      "To capture GPS-tagged video directly from the field"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "The video processing module deployed in the laptop detects weeds and generates coordinates.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 104,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "In the iRobot-Factory architecture, which component is tasked with high-performance, long-term data analytics using artificial intelligence techniques?",
    "options": [
      "Intelligent Terminal",
      "Edge Computing Node",
      "Cognitive Engine",
      "Production Line Layer"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "The Cognitive Engine performs high-performance, long-term data analytics using artificial intelligence techniques.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 105,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "According to the phases of Big Data Driven Smart Manufacturing, what is the primary focus of \"Phase 2\"?",
    "options": [
      "Integration of data and contextual information",
      "Innovation in process and production",
      "Initial deployment of sensor nodes",
      "Synthesis and analysis to build knowledge for decision making"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Phase 2 focuses on synthesis and analysis to build knowledge for decision making.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 106,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "In a Smart Warehousing system, which module is specifically responsible for organizing and processing data, generating events in real-time, and history-based decision making?",
    "options": [
      "Administrative module",
      "Data collection module",
      "RFID tag module",
      "REST-based framework"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "The Administrative module is responsible for organizing and processing data, generating events in real-time, and history-based decision making.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 107,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "In the context of an Industrial Control System (ICS), what is a \"Set Point\"?",
    "options": [
      "The physical location where a sensor is deployed",
      "The standard value of the process parameter for controlled operation",
      "The value of a process parameter measured by a sensor",
      "The actuator used to manipulate the process"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "The Set Point is the standard value of the process parameter for controlled operation.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 108,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Which type of control loop makes control decisions entirely independent of the measured process variable?",
    "options": [
      "Closed Loop Control",
      "Feedback Control",
      "Open Loop Control",
      "Proportional Control"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Open Loop Control makes control decisions entirely independent of the measured process variable.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w7-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 7,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 109,
    "sourcePdfName": "Week 07 : Assignment 07",
    "questionText": "Which of the following is a primary component of a Supervisory Control and Data Acquisition (SCADA) system?",
    "options": [
      "Complex Event Processor (CEP)",
      "Centralized Cloud Services",
      "Unmanned Aerial Vehicles (UAVs)",
      "Remote Telemetry Units (RTUs)"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Remote Telemetry Units (RTUs) are a primary component of a SCADA system interfacing with field devices.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 110,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which type of IIoT analytics is responsible for informing about the remaining useful life of an asset and typically operates on a timescale of hours?",
    "options": [
      "Baseline analytics",
      "Diagnostic analytics",
      "Prescriptive analytics",
      "Prognostic analytics"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Prognostic analytics informs about remaining useful life and operates on a timescale of hours.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 111,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which of the following software tools is highlighted for its use in Complex Event Processing (CEP) during real-time stream analytics?",
    "options": [
      "Apache Hadoop",
      "Apache Spark",
      "Apache Storm",
      "Jupyter"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Apache Storm is highlighted for Complex Event Processing (CEP) during real-time stream analytics.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 112,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "In the context of unsupervised learning, what is a primary distinction of the Fuzzy c-Means (FCM) algorithm compared to K-Means?",
    "options": [
      "FCM allows a data point to belong to more than one cluster",
      "FCM is significantly slower than K-Means",
      "FCM requires a labeled dataset to operate",
      "FCM is categorized as Hard Clustering"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "FCM allows a data point to belong to more than one cluster with varying degrees of membership.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 113,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which supervised learning algorithm is specifically utilized when the output variable to be predicted is a real number (e.g., dollars or weight)?",
    "options": [
      "Classification",
      "Clustering",
      "Reinforcement Learning",
      "Regression"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Regression is specifically utilized when the target output variable to be predicted is a real number.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 114,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "What is a key difference between Reinforcement Learning (RL) and Supervised Learning?",
    "options": [
      "RL is guided by an external supervisor who knows the environment",
      "RL utilizes a reward function that acts as feedback to the agent",
      "RL maps inputs directly to outputs without an agent",
      "Supervised learning models build knowledge graphs from actions"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "RL utilizes a reward function that acts as feedback to the agent based on actions taken.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 115,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which of the following statements best describes why Deep Learning differs from traditional Machine Learning in industrial applications?",
    "options": [
      "Deep learning performs significantly worse as the data volume increases",
      "Deep learning is an \"end-to-end learning\" process that extracts features on its own",
      "Deep learning requires features to be explicitly mentioned by domain experts",
      "Deep learning requires very low computational power"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Deep learning is an \"end-to-end learning\" process that extracts hierarchical features directly from data without manual engineering.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 116,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which company utilizes Collaborative Distributed Deep Learning technology where the learning process is performed in the cloud while inference is conducted at the edge?",
    "options": [
      "Zebra Medical Vision",
      "Intel",
      "H2O",
      "TOSHIBA"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "TOSHIBA utilizes Collaborative Distributed Deep Learning technology.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 117,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which of the following is an example of an industrial Software-as-a-Service (SaaS) application?",
    "options": [
      "Industrial Machinery Catalyst from Siemens",
      "Microsoft Azure",
      "GE Predix",
      "Amazon Web Services (AWS)"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Industrial Machinery Catalyst from Siemens is an industrial SaaS application.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 118,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "A cloud setup that is designed by combining two or more unique cloud infrastructures (public or private) to provide flexibility for data and application movement is called a:",
    "options": [
      "Public Cloud",
      "Community Cloud",
      "Hybrid Cloud",
      "Private Cloud"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "A hybrid cloud combines two or more unique cloud infrastructures (public or private).",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 119,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which industrial cloud platform utilizes \"Digital Twin Technology\" for learning, estimating, optimizing, and representing assets?",
    "options": [
      "Sentience (Honeywell)",
      "GE Predix",
      "Siemens MindSphere",
      "Meshify"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "GE Predix utilizes Digital Twin Technology for learning, estimating, optimizing, and representing assets.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 120,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "The C3 IoT platform provides a storage service for unstructured data known as the C3 Data Lake. In which format is this data primarily managed?",
    "options": [
      "XML format",
      "RESTful format",
      "Simple Object format",
      "SQL Relational format"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "C3 Data Lake manages unstructured data primarily in Simple Object format.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 121,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which of the following industrial IoT platforms specifically provides solutions like \"Now\" and \"Tracker\" for real-time asset tracking with geo-localized data?",
    "options": [
      "Uptake",
      "C3 IoT",
      "Meshify",
      "Honeywell"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Meshify provides solutions like \"Now\" and \"Tracker\" for real-time asset tracking.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 122,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "Which of the following is a crucial feature that an IIoT cloud platform provider should offer for effective device management?",
    "options": [
      "Device decommission",
      "Physical hardware manufacturing",
      "Manual data provisioning",
      "Increasing network blind spots"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Device decommission is a crucial device management feature for security and lifecycle termination.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 123,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "According to Sturm et al., which of the following is one of the defined characteristics of a \"Meaningful SLA\" (Service Level Agreement)?",
    "options": [
      "Subjective",
      "Uncontrollable",
      "Quantifiable",
      "Unachievable"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "According to Sturm et al., a meaningful SLA must be quantifiable.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w8-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 8,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 124,
    "sourcePdfName": "Week 08 : Assignment 08",
    "questionText": "How does Fog Computing primarily address the limitations of a purely centralized cloud-based approach in IIoT?",
    "options": [
      "By identifying useful data and reducing the amount of raw data sent to the cloud",
      "By completely replacing the cloud infrastructure",
      "By increasing the latency of time-sensitive data",
      "By restricting the mobility of edge devices"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Fog Computing identifies useful data and reduces the amount of raw data sent to the cloud.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 125,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "How does fog computing prevent unnecessary noisy big data from crowding the cloud?",
    "options": [
      "By storing all raw data permanently in the cloud",
      "By performing prior filtration at the edge",
      "By disabling real-time control algorithms",
      "By increasing the frequency of sensor transmission"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Fog computing performs prior filtration at the edge to prevent unnecessary noisy big data from crowding the cloud.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 126,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which capability is provided by the fog-based industrial platform?",
    "options": [
      "Merging real-time and non-real-time workloads",
      "Restricting the platform to non-real-time workloads",
      "Transmitting all sensor data without processing",
      "Eliminating control of IoT endpoints"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Fog-based industrial platforms provide the capability of merging real-time and non-real-time workloads.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 127,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which fog-platform provider offers an edge-node software solution that supports any protocol, any PLC, and any hardware?",
    "options": [
      "FogHorn",
      "Sonm",
      "Crosser",
      "Nebbiolo Technologies"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Crosser provides an edge-node software solution that supports any protocol, any PLC, and any hardware.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 128,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "What is the purpose of the %in% special operator in R?",
    "options": [
      "To create a series of numbers for a vector",
      "To check whether an element belongs to a vector",
      "To perform integer division",
      "To assign a value globally"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "In R, %in% checks whether an element belongs to a vector.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 129,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which validation method is used in the demonstrated R machine-learning execution process to estimate model accuracy?",
    "options": [
      "Two-fold cross-validation",
      "Leave-one-out validation",
      "Ten-fold cross-validation",
      "Validation without data partitioning"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Ten-fold cross-validation is used in the demonstrated R execution process.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 130,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which Julia function is used to create a dictionary?",
    "options": [
      "Tuple()",
      "Array()",
      "Dictn()",
      "Dict()"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Dict() is the Julia function used to create a dictionary.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 131,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "During data preprocessing, which operation eliminates repeated data through detection, filtering, and compression?",
    "options": [
      "Data integration",
      "Data cleaning",
      "Redundancy mitigation",
      "Data visualization"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Redundancy mitigation eliminates repeated data through detection, filtering, and compression.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 132,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which Hadoop component assigns CPU, memory, and storage resources to applications running on a Hadoop cluster?",
    "options": [
      "Hadoop Common",
      "Hadoop Distributed File System",
      "MapReduce",
      "Yet Another Resource Negotiator"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Yet Another Resource Negotiator (YARN) assigns CPU, memory, and storage resources.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 133,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which of the following is listed as an application of integrating MongoDB with Hadoop?",
    "options": [
      "Batch aggregation",
      "Physical network cabling",
      "Sensor manufacturing",
      "Firewall configuration"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Batch aggregation is listed as an application of integrating MongoDB with Hadoop.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 134,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which source-routing protocol is used by the BCube data-center network topology?",
    "options": [
      "Border Gateway Protocol",
      "BCube Source Routing",
      "Open Shortest Path First",
      "Spanning Tree Protocol"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "BCube Source Routing is used by the BCube data-center network topology.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 135,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Why may an IIoT-based data center require an increase in inbound network bandwidth?",
    "options": [
      "IIoT devices generate a bulk amount of small messages containing sensor data",
      "IIoT completely removes the need for data transmission",
      "Sensor data is transmitted only once during deployment",
      "Industrial devices communicate exclusively with one another without a data center"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Inbound bandwidth demand increases because IIoT devices generate a bulk amount of small messages containing sensor data.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 136,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which of the following is an advantage of a Software-Defined Data Centre?",
    "options": [
      "Static workload management",
      "Permanent coupling of software with hardware",
      "Programmable infrastructure and workload management",
      "Elimination of network virtualization"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Programmable infrastructure and workload management is an advantage of a Software-Defined Data Centre.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 137,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "When an SDN forwarding device has insufficient rule capacity, how can two existing flow rules be converted into a single rule?",
    "options": [
      "By applying wildcard-based rule combination",
      "By disconnecting the SDN controller",
      "By disabling the forwarding device",
      "By changing TCP into UDP"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Applying wildcard-based rule combination converts multiple matching rules into a single rule.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 138,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "How can SDN meet the dynamically changing forwarding requirements of IIoT sensor data?",
    "options": [
      "By assigning the same priority to every type of data permanently",
      "By using rule-based forwarding policies",
      "By preventing the controller from updating forwarding rules",
      "By transmitting data without considering the real-time situation"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "SDN meets dynamic forwarding requirements by using rule-based forwarding policies.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w9-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 9,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 139,
    "sourcePdfName": "Week 09 : Assignment 09",
    "questionText": "Which statement best describes Software-Defined Automation?",
    "options": [
      "It uses only manually controlled physical equipment",
      "It eliminates real-time control from industrial systems",
      "It uses a virtualized platform for dynamic, real-time system control",
      "It restricts control operations to sensors at Level 0"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "Manually Verified",
    "isApproved": true,
    "explanation": "Software-Defined Automation uses a virtualized platform for dynamic, real-time system control.",
    "createdAt": "2026-09-18T14:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-1",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 1,
    "sourcePageNumber": 1,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "In Software-Defined 6TiSCH, at which layer is the slicing mechanism proposed to isolate SDN control overhead?",
    "options": [
      "Physical Layer",
      "Layer 2",
      "Transport Layer",
      "Application Layer"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "In Software-Defined 6TiSCH, the slicing mechanism is proposed at Layer 2 to isolate SDN control overhead and guarantee QoS for industrial traffic.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-2",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 2,
    "sourcePageNumber": 1,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "In the adaptive transmission architecture for Software-Defined Edge Computing in IIoT, data streams are divided into which two categories?",
    "options": [
      "Local and global data streams",
      "Secure and insecure data streams",
      "Ordinary and emergent data streams",
      "Wired and wireless data streams"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "In the adaptive transmission architecture for Software-Defined Edge Computing in IIoT, data streams are divided into ordinary and emergent data streams.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-3",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 3,
    "sourcePageNumber": 1,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "According to the challenges and opportunities of Software-Defined IIoT, fog nodes/access devices play an important role in providing which type of service?",
    "options": [
      "Delay-constrained emergent services",
      "Long-term archival services",
      "Offline batch-processing services",
      "Manual configuration services"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "According to the challenges and opportunities of Software-Defined IIoT, fog nodes/access devices play an important role in providing delay-constrained emergent services.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-4",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 4,
    "sourcePageNumber": 1,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "In a trustworthy IIoT system, which property refers to the ability of the system to function correctly under dynamic adversarial conditions?",
    "options": [
      "Privacy",
      "Reliability",
      "Safety",
      "Resilience"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "Resilience refers to the ability of the system to function correctly under dynamic adversarial conditions and adapt to disruptions.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-5",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 5,
    "sourcePageNumber": 2,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "In the STRIDE threat model, what does the letter ‘E’ represent?",
    "options": [
      "Encryption",
      "Elevation of privilege",
      "Exposure of information",
      "Endpoint security"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "In the STRIDE threat model (Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege), the letter 'E' represents Elevation of privilege.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-6",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 6,
    "sourcePageNumber": 2,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which participant in the IIoT trust flow is responsible for designing a cost-efficient trustworthy system, defining trust requirements for components, and conducting tests and certifications?",
    "options": [
      "System Owner",
      "End User",
      "System Builder",
      "Cloud Service Provider"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "The System Builder is responsible for designing a cost-efficient trustworthy system, defining component trust requirements, and conducting tests and certifications.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-7",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 7,
    "sourcePageNumber": 2,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which of the following is suggested as a solution for protecting resource-constrained IIoT end devices?",
    "options": [
      "Lightweight symmetric key cryptography",
      "Increasing the size of every transmitted packet",
      "Disabling device authentication",
      "Storing all security operations only in the cloud"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "Lightweight symmetric key cryptography is suggested as an optimal solution for securing resource-constrained IIoT end devices with minimal processing overhead.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-8",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 8,
    "sourcePageNumber": 2,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which three states of data are considered under data protection in IIoT?",
    "options": [
      "Data-at-source, Data-at-cloud, and Data-at-edge",
      "Data-at-Rest, Data-in-Use, and Data-in-Transit",
      "Structured, Semi-structured, and Unstructured data",
      "Sensor data, Control data, and Application data"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "Data protection in IIoT considers three states: Data-at-Rest, Data-in-Use, and Data-in-Transit.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-9",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 9,
    "sourcePageNumber": 2,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which standard listed under OT security provides guidance for security in Industrial Control Systems?",
    "options": [
      "ISO 27017",
      "NIST SP 800-82",
      "ISO/IEC 15408",
      "NIST SP 800-144"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "NIST SP 800-82 provides dedicated guidance for security in Industrial Control Systems (ICS), including SCADA, DCS, and PLCs.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-10",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 10,
    "sourcePageNumber": 2,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which of the following is NOT one of the five layers of Hitachi’s Lumada IoT platform?",
    "options": [
      "Edge",
      "Core",
      "Analytics",
      "Transport"
    ],
    "correctAnswerIndex": 3,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "The five layers of Hitachi's Lumada IoT platform are Edge, Core, Analytics, Studio, and Foundry. Transport is NOT one of them.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-11",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 11,
    "sourcePageNumber": 3,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "In the North Star BlueScope Steel smart-factory application, sensors are used to detect which environmental hazards?",
    "options": [
      "Radiation and toxic gases",
      "Network congestion and packet loss",
      "Inventory shortages and production delays",
      "Voltage fluctuations and cloud failures"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "In North Star BlueScope Steel's smart-factory application, sensors are deployed to detect hazardous radiation and toxic gases to ensure worker safety.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-12",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 12,
    "sourcePageNumber": 3,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "What technology does SmartLabel use to provide product-related information such as ingredients, allergens, and nutritional value to consumers?",
    "options": [
      "RFID tag",
      "Bluetooth beacon",
      "QR code",
      "GPS receiver"
    ],
    "correctAnswerIndex": 2,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "SmartLabel uses QR codes on packaging that consumers scan with smartphones to access detailed product ingredients, allergens, and nutritional facts.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-13",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 13,
    "sourcePageNumber": 3,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "In the Intellicup smart beverage-vending solution, what is integrated at the base of the IoT-enabled cup?",
    "options": [
      "GPS module",
      "NFC chip",
      "Temperature sensor",
      "Wi-Fi router"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "In the Intellicup smart beverage-vending solution, an NFC chip is integrated at the base of the cup to authenticate and regulate pouring.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-14",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 14,
    "sourcePageNumber": 3,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which characteristic of a smart factory allows process parameters such as machine configuration, material flow, and temperature control to be optimally adjusted?",
    "options": [
      "Flexibility",
      "Isolation",
      "Centralization",
      "Redundancy"
    ],
    "correctAnswerIndex": 0,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "Flexibility allows smart factories to automatically and adaptively adjust process parameters such as machine configuration, material flow, and temperature control.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  },
  {
    "id": "q-iiot-w10-15",
    "courseId": "course-iiot-cps-master",
    "weekNumber": 10,
    "originalQuestionNumber": 15,
    "sourcePageNumber": 4,
    "sourcePdfName": "NPTEL_WEEK-10.pdf",
    "questionText": "Which network-security mechanism acts as a fence between a trusted internal network and an unauthorized external network and uses a set of rules to allow or block traffic?",
    "options": [
      "Hypervisor",
      "Firewall",
      "Load balancer",
      "Data logger"
    ],
    "correctAnswerIndex": 1,
    "answerSource": "PDF",
    "isApproved": true,
    "explanation": "A firewall acts as a protective boundary between a trusted internal network and unauthorized external networks, filtering network traffic based on established security rules.",
    "createdAt": "2026-09-30T10:00:00.000Z"
  }
];

List<CourseModel> getInitialCourses() {
  return rawInitialCourses.map((c) => CourseModel.fromJson(c)).toList();
}

List<QuestionModel> getInitialQuestions() {
  return rawInitialQuestions.map((q) => QuestionModel.fromJson(q)).toList();
}
