import '../models/class_model.dart';

class CurriculumData {
  static const List<ClassModel> classes = [
    ClassModel(classNumber: 1, label: 'Class 1', emoji: '🌱', group: 'Primary'),
    ClassModel(classNumber: 2, label: 'Class 2', emoji: '🌿', group: 'Primary'),
    ClassModel(classNumber: 3, label: 'Class 3', emoji: '🍀', group: 'Primary'),
    ClassModel(classNumber: 4, label: 'Class 4', emoji: '🌼', group: 'Primary'),
    ClassModel(classNumber: 5, label: 'Class 5', emoji: '🌻', group: 'Primary'),
    ClassModel(classNumber: 6, label: 'Class 6', emoji: '📘', group: 'Middle'),
    ClassModel(classNumber: 7, label: 'Class 7', emoji: '📗', group: 'Middle'),
    ClassModel(classNumber: 8, label: 'Class 8', emoji: '📙', group: 'Middle'),
    ClassModel(classNumber: 9, label: 'Class 9', emoji: '🔬', group: 'Secondary'),
    ClassModel(classNumber: 10, label: 'Class 10', emoji: '🏆', group: 'Secondary'),
    ClassModel(classNumber: 11, label: 'Class 11', emoji: '🎓', group: 'Senior'),
    ClassModel(classNumber: 12, label: 'Class 12', emoji: '🚀', group: 'Senior'),
  ];

  static List<SubjectModel> getSubjects(int classNumber) {
    if (classNumber <= 3) {
      return _class1to3Subjects;
    } else if (classNumber <= 5) {
      return _class4to5Subjects;
    } else if (classNumber <= 8) {
      return _middleSubjects;
    } else if (classNumber <= 10) {
      return _secondarySubjects;
    } else {
      return _seniorSubjects;
    }
  }

  static const List<SubjectModel> _class1to3Subjects = [
    SubjectModel(
      name: 'Mathematics',
      emoji: '🔢',
      color: '#4CAF50',
      topics: [
        'Numbers & Counting',
        'Addition & Subtraction',
        'Multiplication & Division',
        'Shapes & Geometry',
        'Measurement',
        'Patterns',
      ],
    ),
    SubjectModel(
      name: 'English',
      emoji: '📖',
      color: '#2196F3',
      topics: [
        'Alphabet & Phonics',
        'Reading',
        'Writing',
        'Grammar Basics',
        'Vocabulary',
        'Stories & Poems',
      ],
    ),
    SubjectModel(
      name: 'Hindi',
      emoji: '🇮🇳',
      color: '#FF9800',
      topics: [
        'वर्णमाला',
        'मात्राएँ',
        'शब्द भंडार',
        'वाक्य रचना',
        'कहानियाँ',
        'कविताएँ',
      ],
    ),
    SubjectModel(
      name: 'EVS',
      emoji: '🌍',
      color: '#009688',
      topics: [
        'My Body',
        'My Family',
        'Plants & Animals',
        'Food & Water',
        'Weather & Seasons',
        'Transport',
      ],
    ),
    SubjectModel(
      name: 'Drawing & Art',
      emoji: '🎨',
      color: '#E91E63',
      topics: [
        'Basic Shapes',
        'Colors',
        'Nature Drawing',
        'Coloring',
        'Clay Modelling',
        'Craft',
      ],
    ),
    SubjectModel(
      name: 'General Knowledge',
      emoji: '💡',
      color: '#9C27B0',
      topics: [
        'Our Country',
        'National Symbols',
        'Fruits & Vegetables',
        'Animals & Birds',
        'Festivals',
        'Famous People',
      ],
    ),
  ];

  // Class 4 & 5 – same as 1–3 but adds Science
  static const List<SubjectModel> _class4to5Subjects = [
    SubjectModel(
      name: 'Mathematics',
      emoji: '🔢',
      color: '#4CAF50',
      topics: [
        'Numbers & Counting',
        'Addition & Subtraction',
        'Multiplication & Division',
        'Shapes & Geometry',
        'Measurement',
        'Fractions',
      ],
    ),
    SubjectModel(
      name: 'Science',
      emoji: '🔬',
      color: '#3F51B5',
      topics: [
        'Plants Around Us',
        'Animals - Domestic & Wild',
        'Food We Eat',
        'Our Body',
        'Water & Its Uses',
        'Weather & Seasons',
        'Simple Machines',
      ],
    ),
    SubjectModel(
      name: 'English',
      emoji: '📖',
      color: '#2196F3',
      topics: [
        'Reading',
        'Grammar Basics',
        'Vocabulary',
        'Writing Skills',
        'Stories & Poems',
      ],
    ),
    SubjectModel(
      name: 'Hindi',
      emoji: '🇮🇳',
      color: '#FF9800',
      topics: [
        'वर्णमाला',
        'मात्राएँ',
        'शब्द भंडार',
        'वाक्य रचना',
        'कहानियाँ',
        'कविताएँ',
      ],
    ),
    SubjectModel(
      name: 'Social Studies',
      emoji: '🗺️',
      color: '#795548',
      topics: [
        'Our Country',
        'Maps & Directions',
        'Our History',
        'Transport & Communication',
        'Our Environment',
        'Civic Life',
      ],
    ),
    SubjectModel(
      name: 'General Knowledge',
      emoji: '💡',
      color: '#9C27B0',
      topics: [
        'Current Affairs',
        'Science Facts',
        'Famous Personalities',
        'Sports',
        'World Records',
        'Inventions',
      ],
    ),
  ];

  static const List<SubjectModel> _middleSubjects = [
    SubjectModel(
      name: 'Mathematics',
      emoji: '🔢',
      color: '#4CAF50',
      topics: [
        'Integers',
        'Fractions & Decimals',
        'Algebra Basics',
        'Geometry',
        'Ratio & Proportion',
        'Mensuration',
        'Data Handling',
      ],
    ),
    SubjectModel(
      name: 'Science',
      emoji: '🔬',
      color: '#3F51B5',
      topics: [
        'Food & Nutrition',
        'Fibre to Fabric',
        'Living Organisms',
        'Motion & Time',
        'Electric Current',
        'Light',
        'Water & Weather',
      ],
    ),
    SubjectModel(
      name: 'English',
      emoji: '📖',
      color: '#2196F3',
      topics: [
        'Reading Comprehension',
        'Grammar',
        'Writing Skills',
        'Literature',
        'Vocabulary',
        'Communication',
      ],
    ),
    SubjectModel(
      name: 'Hindi',
      emoji: '🇮🇳',
      color: '#FF9800',
      topics: [
        'गद्य पाठ',
        'पद्य पाठ',
        'व्याकरण',
        'लेखन',
        'संधि-विच्छेद',
        'मुहावरे',
      ],
    ),
    SubjectModel(
      name: 'Social Studies',
      emoji: '🗺️',
      color: '#795548',
      topics: [
        'History',
        'Geography',
        'Civics',
        'Our Constitution',
        'Resources',
        'Disaster Management',
      ],
    ),
    SubjectModel(
      name: 'Sanskrit',
      emoji: '📜',
      color: '#FF5722',
      topics: [
        'वर्णमाला',
        'धातु रूप',
        'शब्द रूप',
        'अनुवाद',
        'श्लोक',
        'सुभाषितानि',
      ],
    ),
    SubjectModel(
      name: 'Computer Science',
      emoji: '💻',
      color: '#607D8B',
      topics: [
        'Introduction to Computers',
        'MS Office',
        'Internet Basics',
        'Scratch Programming',
        'Cyber Safety',
        'Multimedia',
      ],
    ),
  ];

  static const List<SubjectModel> _secondarySubjects = [
    SubjectModel(
      name: 'Mathematics',
      emoji: '🔢',
      color: '#4CAF50',
      topics: [
        'Real Numbers',
        'Polynomials',
        'Pair of Linear Equations',
        'Quadratic Equations',
        'Arithmetic Progressions',
        'Triangles',
        'Coordinate Geometry',
        'Statistics & Probability',
      ],
    ),
    SubjectModel(
      name: 'Science',
      emoji: '⚗️',
      color: '#3F51B5',
      topics: [
        'Physics: Motion & Forces',
        'Physics: Light & Electricity',
        'Chemistry: Atoms & Molecules',
        'Chemistry: Reactions',
        'Biology: Life Processes',
        'Biology: Reproduction',
        'Natural Resources',
      ],
    ),
    SubjectModel(
      name: 'English',
      emoji: '📖',
      color: '#2196F3',
      topics: [
        'Literature – Prose',
        'Literature – Poetry',
        'Grammar',
        'Writing – Essays',
        'Writing – Letters',
        'Reading Skills',
      ],
    ),
    SubjectModel(
      name: 'Hindi',
      emoji: '🇮🇳',
      color: '#FF9800',
      topics: [
        'क्षितिज – गद्य',
        'क्षितिज – पद्य',
        'कृतिका',
        'व्याकरण',
        'लेखन',
        'अपठित गद्यांश',
      ],
    ),
    SubjectModel(
      name: 'Social Science',
      emoji: '🗺️',
      color: '#795548',
      topics: [
        'History – India & World',
        'Geography – Resources',
        'Political Science',
        'Economics',
        'Disaster Management',
        'Map Work',
      ],
    ),
    SubjectModel(
      name: 'Computer Applications',
      emoji: '💻',
      color: '#607D8B',
      topics: [
        'Networking',
        'HTML & CSS',
        'Python Basics',
        'Database Concepts',
        'Cyber Ethics',
        'Digital Literacy',
      ],
    ),
    SubjectModel(
      name: 'Sanskrit',
      emoji: '📜',
      color: '#FF5722',
      topics: [
        'शेमुषी',
        'अभ्यासवान् भव',
        'व्याकरणवीथि',
        'अनुवाद',
        'पत्र लेखन',
        'निबन्ध लेखन',
      ],
    ),
  ];

  static const List<SubjectModel> _seniorSubjects = [
    SubjectModel(
      name: 'Physics',
      emoji: '⚡',
      color: '#3F51B5',
      topics: [
        'Electric Charges & Fields',
        'Current Electricity',
        'Magnetism',
        'Electromagnetic Induction',
        'Optics',
        'Modern Physics',
        'Semiconductor Devices',
      ],
    ),
    SubjectModel(
      name: 'Chemistry',
      emoji: '⚗️',
      color: '#9C27B0',
      topics: [
        'Solid State',
        'Solutions',
        'Electrochemistry',
        'Chemical Kinetics',
        'Organic Chemistry',
        'Coordination Compounds',
        'Biomolecules',
      ],
    ),
    SubjectModel(
      name: 'Mathematics',
      emoji: '🔢',
      color: '#4CAF50',
      topics: [
        'Relations & Functions',
        'Inverse Trigonometry',
        'Matrices & Determinants',
        'Calculus – Differentiation',
        'Calculus – Integration',
        'Probability',
        'Linear Programming',
        'Vectors & 3D Geometry',
      ],
    ),
    SubjectModel(
      name: 'Biology',
      emoji: '🧬',
      color: '#009688',
      topics: [
        'Reproduction',
        'Genetics & Evolution',
        'Human Physiology',
        'Biotechnology',
        'Ecology',
        'Organisms & Environment',
      ],
    ),
    SubjectModel(
      name: 'English',
      emoji: '📖',
      color: '#2196F3',
      topics: [
        'Flamingo – Prose',
        'Flamingo – Poetry',
        'Vistas',
        'Writing Skills',
        'Grammar',
        'Reading Comprehension',
      ],
    ),
    SubjectModel(
      name: 'Computer Science',
      emoji: '💻',
      color: '#607D8B',
      topics: [
        'Python Programming',
        'OOP Concepts',
        'Data Structures',
        'Database & SQL',
        'Computer Networks',
        'Cyber Security',
      ],
    ),
    SubjectModel(
      name: 'Accountancy',
      emoji: '📊',
      color: '#FF9800',
      topics: [
        'Partnership Accounts',
        'Company Accounts',
        'Cash Flow Statement',
        'Financial Statements',
        'Ratio Analysis',
        'Computerized Accounting',
      ],
    ),
    SubjectModel(
      name: 'Economics',
      emoji: '💹',
      color: '#F44336',
      topics: [
        'Introduction to Economics',
        'Demand & Supply',
        'Production & Cost',
        'Market Forms',
        'National Income',
        'Government Budget',
        'Foreign Exchange',
      ],
    ),
    SubjectModel(
      name: 'Business Studies',
      emoji: '🏢',
      color: '#795548',
      topics: [
        'Nature of Business',
        'Forms of Business',
        'Business Finance',
        'Marketing',
        'Consumer Protection',
        'Management Principles',
      ],
    ),
    SubjectModel(
      name: 'History',
      emoji: '🏛️',
      color: '#FF5722',
      topics: [
        'Bricks, Beads & Bones',
        'Kings, Farmers & Towns',
        'Colonial Cities',
        'Nationalism in India',
        'Mahatma Gandhi',
        'Partition & Independence',
        'Contemporary World',
      ],
    ),
    SubjectModel(
      name: 'Geography',
      emoji: '🌏',
      color: '#4CAF50',
      topics: [
        'Human Geography',
        'Population',
        'Human Development',
        'Primary Activities',
        'Secondary Activities',
        'Transport & Communication',
        'International Trade',
      ],
    ),
  ];
}
