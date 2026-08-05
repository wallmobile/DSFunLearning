import '../models/question_model.dart';

class QuestionsData {
  /// Key format: "SubjectName|TopicName"
  static List<Question> getQuestions(String subject, String topic) {
    final key = '$subject|$topic';
    return _data[key] ?? [];
  }

  static final Map<String, List<Question>> _data = {
    // ─────────────────────────────────────────────
    // SCIENCE – CLASS 4 & 5
    // ─────────────────────────────────────────────
    'Science|Plants Around Us': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'Which part of the plant makes food using sunlight?',
        options: ['Root', 'Stem', 'Leaf', 'Flower'],
        correctIndex: 2,
        answer: 'Leaf',
        hint: 'It is green and flat, and traps sunlight.',
        explanation:
            'Leaves contain chlorophyll which traps sunlight to make food through photosynthesis.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'What do plants need for photosynthesis?',
        options: [
          'Water, sunlight, CO₂',
          'Only water',
          'Soil and wind',
          'Oxygen and fire',
        ],
        correctIndex: 0,
        answer: 'Water, sunlight and carbon dioxide (CO₂)',
        hint: 'Think of what a plant needs to prepare its food.',
        explanation:
            'Plants take in water through roots, CO₂ through stomata, and use sunlight energy to produce glucose and oxygen.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which type of plant lives in water?',
        options: ['Cactus', 'Lotus', 'Mango', 'Neem'],
        correctIndex: 1,
        answer: 'Lotus',
        hint: 'It is a beautiful flower found in ponds.',
        explanation:
            'Lotus is an aquatic plant. Its roots are in mud, but leaves and flowers float on water.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'The process by which plants make their own food is called ______.',
        answer: 'Photosynthesis',
        hint: 'Photo = light, synthesis = making.',
        explanation:
            'Photosynthesis is the process where plants use light energy to convert CO₂ and water into glucose.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The green pigment in leaves is called ______.',
        answer: 'Chlorophyll',
        hint: 'It gives leaves their green colour.',
        explanation:
            'Chlorophyll is the pigment that absorbs sunlight and gives plants their green colour.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'Plants that shed their leaves in autumn are called ______ plants.',
        answer: 'Deciduous',
        hint: 'Think of trees like oak and maple that lose leaves seasonally.',
        explanation:
            'Deciduous plants shed leaves in autumn to conserve water during cold or dry seasons.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'What are the main functions of roots?',
        answer:
            'Roots anchor the plant in the soil, absorb water and minerals from the soil, and store food in some plants (like carrots and radish).',
        hint: 'Think about what keeps a plant standing and what it drinks.',
        explanation:
            'Roots are underground organs. Taproot systems have one main root (carrot), while fibrous roots are a mass of thin roots (grass).',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What is the difference between herbs, shrubs and trees?',
        answer:
            'Herbs are small plants with soft green stems (e.g. mint). Shrubs are medium-sized plants with woody stems branching near the base (e.g. rose). Trees are tall plants with a single hard woody trunk (e.g. mango).',
        hint: 'Compare their height and stem type.',
        explanation:
            'Plants are classified by size and stem type. Herbs live for 1–2 years, shrubs are perennial, and trees can live for hundreds of years.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'How do plants in deserts survive without much water?',
        answer:
            'Desert plants like cactus have thick waxy stems to store water, spines instead of leaves to reduce water loss, and deep roots to reach underground water.',
        hint: 'Think about how a cactus looks different from a normal plant.',
        explanation:
            'Desert plants are called xerophytes. Their special adaptations help them survive in hot, dry conditions where water is very scarce.',
      ),
    ],

    'Science|Animals - Domestic & Wild': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'Which of these is a domestic animal?',
        options: ['Lion', 'Tiger', 'Cow', 'Elephant'],
        correctIndex: 2,
        answer: 'Cow',
        hint: 'It is kept at home for milk.',
        explanation:
            'Domestic animals are tamed and kept by humans for their products or companionship. Cow gives us milk and is a domestic animal.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Animals that eat only plants are called:',
        options: ['Carnivores', 'Herbivores', 'Omnivores', 'Scavengers'],
        correctIndex: 1,
        answer: 'Herbivores',
        hint: 'Herbi = plant, vore = eat.',
        explanation:
            'Herbivores like cows, deer, and rabbits eat only plant material such as grass, leaves, and fruits.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which animal can live both on land and in water?',
        options: ['Snake', 'Frog', 'Crow', 'Rabbit'],
        correctIndex: 1,
        answer: 'Frog',
        hint: 'It lays eggs in water but hops on land.',
        explanation:
            'Frogs are amphibians. They breathe through lungs on land and can also breathe through their moist skin in water.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'Animals that feed on both plants and animals are called ______.',
        answer: 'Omnivores',
        hint: 'Omni = all. Think of bears and humans.',
        explanation:
            'Omnivores have a varied diet. Examples include humans, bears, dogs, and crows.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'Animals that are active at night are called ______ animals.',
        answer: 'Nocturnal',
        hint: 'Noc = night. Owls are a good example.',
        explanation:
            'Nocturnal animals like owls, bats, and foxes have adapted eyes to see well in the dark.',
      ),
      Question(
        type: QuestionType.fillup,
        question:
            'The process of an animal going into deep sleep during winter is called ______.',
        answer: 'Hibernation',
        hint: 'Bears do this in cold winters.',
        explanation:
            'Hibernation is a state of inactivity to survive cold winters when food is scarce. Bears, hedgehogs, and snakes hibernate.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'What are the differences between wild and domestic animals?',
        answer:
            'Wild animals live freely in forests and jungles (e.g. tiger, lion). They find their own food and shelter. Domestic animals are tamed and live with humans (e.g. dog, cow). Humans provide them food, shelter and care.',
        hint: 'Think about where each type of animal lives and who takes care of them.',
        explanation:
            'Over thousands of years, humans domesticated animals like dogs (from wolves) and cows for food, work, and companionship.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What are the uses of domestic animals?',
        answer:
            'Domestic animals are useful in many ways: Cow and buffalo give milk; Hen gives eggs; Horses, donkeys, and camels carry loads; Dogs guard homes; Sheep give wool; Silkworm gives silk.',
        hint: 'Think of what we get from animals like cow, hen, sheep, and dog.',
        explanation:
            'Domestic animals have been selectively bred over centuries to enhance useful traits like milk production, speed, or wool quality.',
      ),
    ],

    'Science|Food We Eat': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'Which nutrient gives us energy to work and play?',
        options: ['Vitamins', 'Minerals', 'Carbohydrates', 'Water'],
        correctIndex: 2,
        answer: 'Carbohydrates',
        hint: 'Rice, bread and potatoes are rich in this nutrient.',
        explanation:
            'Carbohydrates are the main energy source. They are found in rice, wheat, potatoes, and sugar.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which food is rich in protein?',
        options: ['Sugar', 'Rice', 'Egg', 'Butter'],
        correctIndex: 2,
        answer: 'Egg',
        hint: 'Body-building foods come from this category.',
        explanation:
            'Proteins are body-building nutrients found in eggs, pulses, fish, meat, and milk. They help repair and grow body cells.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'What is a balanced diet?',
        options: [
          'Eating only vegetables',
          'Eating foods with all nutrients in right amounts',
          'Eating only fruits',
          'Eating sweets every day',
        ],
        correctIndex: 1,
        answer: 'Eating foods containing all nutrients in the right amounts',
        hint: 'Balance means having the right mix of everything.',
        explanation:
            'A balanced diet includes carbohydrates, proteins, fats, vitamins, minerals, and water in correct proportions for good health.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'Vitamins and minerals are called ______ nutrients.',
        answer: 'Protective',
        hint: 'They protect our body from diseases.',
        explanation:
            'Vitamins and minerals protect us from diseases and help the body function properly. Fruits and vegetables are rich in them.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'Deficiency of Vitamin C causes a disease called ______.',
        answer: 'Scurvy',
        hint: 'It was common among sailors who did not eat fresh fruits.',
        explanation:
            'Scurvy causes bleeding gums and weakness. Vitamin C is found in citrus fruits like oranges, lemons, and amla.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'Fats provide ______ energy compared to carbohydrates.',
        answer: 'More',
        hint: 'Fats are a concentrated energy source.',
        explanation:
            'Fats provide twice the energy of carbohydrates per gram. Butter, ghee, oil, and nuts are sources of fats.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'What are the main nutrients found in food and their functions?',
        answer:
            '1. Carbohydrates – provide energy (rice, wheat). 2. Proteins – build and repair body (pulses, eggs). 3. Fats – provide energy and warmth (butter, oil). 4. Vitamins – protect from disease (fruits, vegetables). 5. Minerals – build strong bones and teeth (milk, green vegetables). 6. Water – helps digestion and removes waste.',
        hint: 'Think of the six types of nutrients we study.',
        explanation:
            'Each nutrient has a unique role. Eating a variety of foods ensures all nutrients are obtained in adequate amounts.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What is the importance of water in our diet?',
        answer:
            'Water makes up about 70% of our body. It helps in digestion, carries nutrients in blood, removes waste through urine and sweat, and regulates body temperature. We should drink at least 8 glasses of water daily.',
        hint: 'Think about what happens when you get dehydrated.',
        explanation:
            'Without water, chemical reactions in the body cannot occur. Dehydration leads to weakness, headaches, and in severe cases, organ failure.',
      ),
    ],

    'Science|Our Body': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'Which organ pumps blood throughout the body?',
        options: ['Lungs', 'Brain', 'Heart', 'Liver'],
        correctIndex: 2,
        answer: 'Heart',
        hint: 'You can feel it beat in your chest.',
        explanation:
            'The heart is a muscular organ that pumps blood continuously. It beats about 70 times per minute in an adult.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'How many bones are there in an adult human body?',
        options: ['106', '206', '306', '406'],
        correctIndex: 1,
        answer: '206',
        hint: 'It is slightly more than 200.',
        explanation:
            'An adult human body has 206 bones. Babies are born with about 270 bones, which fuse together as they grow.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which organ controls all the activities of our body?',
        options: ['Heart', 'Stomach', 'Brain', 'Kidney'],
        correctIndex: 2,
        answer: 'Brain',
        hint: 'It is protected by the skull.',
        explanation:
            'The brain is the control centre of the body. It controls thinking, memory, movement, and all body functions through the nervous system.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'The organ that filters waste from the blood is called the ______.',
        answer: 'Kidney',
        hint: 'There are two of them shaped like beans.',
        explanation:
            'Kidneys filter blood and remove waste in the form of urine. They help maintain the balance of water and minerals in the body.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The bones and muscles together form the ______ system.',
        answer: 'Musculo-skeletal',
        hint: 'Bones give structure, muscles allow movement.',
        explanation:
            'The musculo-skeletal system provides shape, support, and enables movement. Bones are connected by joints, and muscles pull on bones to cause movement.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The largest organ of the human body is the ______.',
        answer: 'Skin',
        hint: 'It covers your entire body.',
        explanation:
            'Skin is the largest organ. It protects internal organs, regulates temperature, and contains sense receptors for touch, heat, and pain.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'What are the main organ systems of the human body?',
        answer:
            '1. Digestive system – breaks down food. 2. Respiratory system – breathing (lungs). 3. Circulatory system – pumps blood (heart). 4. Skeletal system – gives shape (bones). 5. Nervous system – sends signals (brain, nerves). 6. Excretory system – removes waste (kidneys).',
        hint: 'Think of the major organs and what they do together.',
        explanation:
            'The human body has 11 organ systems. Each has a specific function, and they all work together to keep the body healthy.',
      ),
    ],

    'Science|Water & Its Uses': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'Water covers approximately what percentage of Earth\'s surface?',
        options: ['30%', '50%', '71%', '90%'],
        correctIndex: 2,
        answer: '71%',
        hint: 'More than half, much more.',
        explanation:
            '71% of Earth\'s surface is covered with water. However, only about 3% is fresh water, and most of that is frozen in glaciers.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which process converts water into water vapour?',
        options: ['Condensation', 'Evaporation', 'Precipitation', 'Freezing'],
        correctIndex: 1,
        answer: 'Evaporation',
        hint: 'Think of puddles drying up on a sunny day.',
        explanation:
            'Evaporation is the process where liquid water changes to water vapour due to heat. It is a key part of the water cycle.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which method is used to remove dissolved salts from water?',
        options: ['Boiling', 'Filtration', 'Distillation', 'Sedimentation'],
        correctIndex: 2,
        answer: 'Distillation',
        hint: 'This method involves boiling and cooling water separately.',
        explanation:
            'Distillation involves boiling water to create steam, then cooling it back into liquid. The dissolved salts remain behind.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'The continuous movement of water between Earth and atmosphere is called the ______ cycle.',
        answer: 'Water',
        hint: 'Evaporation → clouds → rain → back to earth.',
        explanation:
            'The water cycle involves evaporation, condensation, precipitation, and collection. It is driven by solar energy.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'Water that collects underground in rocks is called ______ water.',
        answer: 'Ground',
        hint: 'We access it through wells and borewells.',
        explanation:
            'Groundwater is stored in aquifers underground. It is accessed through wells. Over-extraction leads to depleting groundwater levels.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'Why is water conservation important?',
        answer:
            'Fresh water is limited (only 3% of Earth\'s water). Population growth increases demand. Pollution and wastage reduce available water. Without water, no life can survive. We must save water by fixing leaks, using water wisely, rainwater harvesting, and planting trees.',
        hint: 'Think about how much fresh water we actually have.',
        explanation:
            'Water scarcity affects over 2 billion people worldwide. Simple habits like turning off taps and rainwater harvesting can make a big difference.',
      ),
    ],

    'Science|Weather & Seasons': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'Which instrument is used to measure rainfall?',
        options: ['Thermometer', 'Barometer', 'Rain gauge', 'Anemometer'],
        correctIndex: 2,
        answer: 'Rain gauge',
        hint: 'It collects and measures the amount of rain.',
        explanation:
            'A rain gauge collects rainfall in a cylinder and measures its depth in millimetres. It is placed in open areas.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Clouds are made of:',
        options: ['Dust particles', 'Tiny water droplets', 'Smoke', 'Gases'],
        correctIndex: 1,
        answer: 'Tiny water droplets',
        hint: 'Water vapour cools and condenses high up.',
        explanation:
            'Clouds form when water vapour rises and cools, condensing into tiny water droplets around dust particles. When droplets get heavy, they fall as rain.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'The instrument used to measure temperature is called a ______.',
        answer: 'Thermometer',
        hint: 'Thermo = heat, meter = measure.',
        explanation:
            'A thermometer measures temperature in degrees Celsius (°C) or Fahrenheit (°F). Clinical thermometers measure body temperature.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'India receives most of its rainfall during the ______ season.',
        answer: 'Monsoon',
        hint: 'This season comes after summer, around June–September.',
        explanation:
            'The Indian monsoon brings about 80% of India\'s annual rainfall between June and September due to moist winds from the Indian Ocean.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'What causes the four seasons?',
        answer:
            'The four seasons – summer, monsoon, autumn, winter – are caused by Earth\'s revolution around the Sun and its tilted axis. When a part of Earth tilts toward the Sun, it experiences summer. When tilted away, it experiences winter.',
        hint: 'Think about Earth moving around the Sun.',
        explanation:
            'Earth\'s axis is tilted at 23.5°. As it revolves around the Sun over a year, different parts receive more or less direct sunlight, causing seasons.',
      ),
    ],

    'Science|Simple Machines': [
      // MCQ
      Question(
        type: QuestionType.mcq,
        question: 'A see-saw is an example of which simple machine?',
        options: ['Pulley', 'Wedge', 'Lever', 'Screw'],
        correctIndex: 2,
        answer: 'Lever',
        hint: 'It has a fulcrum (pivot) in the middle.',
        explanation:
            'A lever is a rigid bar that pivots on a fulcrum. A see-saw, scissors, and a crowbar are all levers. They multiply force.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which simple machine is used to lift heavy loads using a rope?',
        options: ['Lever', 'Wedge', 'Pulley', 'Inclined plane'],
        correctIndex: 2,
        answer: 'Pulley',
        hint: 'It is used in cranes and flagpoles.',
        explanation:
            'A pulley is a wheel with a groove through which a rope passes. It changes the direction of force and can multiply force with a block and tackle system.',
      ),
      // Fill-ups
      Question(
        type: QuestionType.fillup,
        question: 'A ramp or slope used to move heavy objects is called an ______ plane.',
        answer: 'Inclined',
        hint: 'Think of a road that goes uphill gradually.',
        explanation:
            'An inclined plane reduces the effort needed to lift objects. Moving trucks use loading ramps as inclined planes.',
      ),
      Question(
        type: QuestionType.fillup,
        question:
            'Simple machines make work ______ by reducing the effort needed.',
        answer: 'Easier',
        hint: 'The whole purpose of a machine is to help us.',
        explanation:
            'Simple machines reduce the force needed to do work or change the direction of force. The 6 simple machines are: lever, pulley, wheel & axle, inclined plane, wedge, screw.',
      ),
      // Q&A
      Question(
        type: QuestionType.qna,
        question: 'Name six simple machines and give one example of each.',
        answer:
            '1. Lever – see-saw, scissors\n2. Pulley – flagpole, crane\n3. Wheel & axle – bicycle wheel, steering wheel\n4. Inclined plane – ramp, staircase\n5. Wedge – knife, axe\n6. Screw – bolt, jar lid',
        hint: 'There are exactly 6 types of simple machines.',
        explanation:
            'All complex machines are combinations of these 6 simple machines. They help us do work with less effort by trading force for distance.',
      ),
    ],

    // ─────────────────────────────────────────────
    // MATHEMATICS – CLASS 4 & 5
    // ─────────────────────────────────────────────
    'Mathematics|Numbers & Counting': [
      Question(
        type: QuestionType.mcq,
        question: 'What is the place value of 7 in 3,752?',
        options: ['Ones', 'Tens', 'Hundreds', 'Thousands'],
        correctIndex: 2,
        answer: 'Hundreds',
        hint: 'Count the place from the right: ones, tens, hundreds.',
        explanation:
            '3,752 = 3 thousands + 7 hundreds + 5 tens + 2 ones. So 7 is in the hundreds place, its value is 700.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which is the largest 4-digit number?',
        options: ['1000', '9000', '9999', '10000'],
        correctIndex: 2,
        answer: '9999',
        hint: 'Fill all 4 places with the biggest single digit.',
        explanation:
            '9999 is the largest 4-digit number. Adding 1 gives 10000, which is the smallest 5-digit number.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The number that comes just before 10,000 is ______.',
        answer: '9,999',
        hint: 'Subtract 1 from 10,000.',
        explanation:
            '10,000 − 1 = 9,999. This is the greatest 4-digit number.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'In 5,308 the digit in the tens place is ______.',
        answer: '0',
        hint: 'Tens place is the second position from the right.',
        explanation:
            '5,308: 8 is in ones, 0 is in tens, 3 is in hundreds, 5 is in thousands. The tens digit is 0.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What is the difference between face value and place value?',
        answer:
            'Face value is the value of a digit itself, regardless of its position. Place value is the value of a digit based on its position in the number. Example: In 4,567, the face value of 5 is 5, but its place value is 500 (since it is in the hundreds place).',
        hint: 'Face = the digit itself. Place = where it sits.',
        explanation:
            'Face value never changes. Place value depends on position. This concept is fundamental to our decimal number system.',
      ),
    ],

    'Mathematics|Addition & Subtraction': [
      Question(
        type: QuestionType.mcq,
        question: 'What is 4,538 + 2,746?',
        options: ['7,284', '7,184', '6,284', '7,384'],
        correctIndex: 0,
        answer: '7,284',
        hint: 'Add column by column from right to left, carry over if needed.',
        explanation:
            '8+6=14 (write 4, carry 1), 3+4+1=8, 5+7=12 (write 2, carry 1), 4+2+1=7. Answer: 7,284.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'What is 8,000 − 3,456?',
        options: ['4,544', '4,454', '5,544', '4,644'],
        correctIndex: 0,
        answer: '4,544',
        hint: 'Use borrowing method from left.',
        explanation:
            '8,000 − 3,456 = 4,544. You can check: 4,544 + 3,456 = 8,000.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The sum of 1,234 and 2,345 is ______.',
        answer: '3,579',
        hint: 'Add each column: 4+5=9, 3+4=7, 2+3=5, 1+2=3.',
        explanation: '1,234 + 2,345 = 3,579. No carrying is needed here.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'A school has 2,456 boys and 1,897 girls. How many students are there in all? If 345 students are absent, how many are present?',
        answer:
            'Total students = 2,456 + 1,897 = 4,353. Students present = 4,353 − 345 = 4,008.',
        hint: 'First add boys and girls, then subtract absent students.',
        explanation:
            'Step 1: Addition – 2,456 + 1,897 = 4,353. Step 2: Subtraction – 4,353 − 345 = 4,008.',
      ),
    ],

    'Mathematics|Multiplication & Division': [
      Question(
        type: QuestionType.mcq,
        question: 'What is 234 × 6?',
        options: ['1,404', '1,304', '1,440', '1,204'],
        correctIndex: 0,
        answer: '1,404',
        hint: 'Multiply 6 with each digit from right: 6×4, 6×3, 6×2.',
        explanation:
            '6×4=24 (write 4, carry 2), 6×3+2=20 (write 0, carry 2), 6×2+2=14. Answer: 1,404.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'What is 1,260 ÷ 4?',
        options: ['305', '315', '325', '310'],
        correctIndex: 1,
        answer: '315',
        hint: 'Divide 1,260 step by step: 12÷4=3, bring down 6, 6÷4...',
        explanation:
            '12÷4=3, remainder 0. Bring down 6: 6÷4=1 remainder 2. Bring down 0: 20÷4=5. Answer: 315.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The product of 45 and 8 is ______.',
        answer: '360',
        hint: '45 × 8: first 5×8=40, write 0 carry 4; then 4×8+4=36.',
        explanation: '45 × 8 = 360. Checking: 360 ÷ 8 = 45. ✓',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'When a number is divided by itself, the quotient is always ______.',
        answer: '1',
        hint: 'Any number ÷ itself = ?',
        explanation:
            'Any non-zero number divided by itself equals 1. e.g. 5÷5=1, 100÷100=1.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'A box has 24 chocolates. How many chocolates are there in 15 such boxes? If they are shared equally among 9 children, how many does each child get?',
        answer:
            'Total chocolates = 24 × 15 = 360. Each child gets = 360 ÷ 9 = 40 chocolates.',
        hint: 'Multiply first, then divide.',
        explanation:
            '24 × 15: 24×5=120, 24×10=240, total=360. 360÷9=40. Each child gets 40 chocolates.',
      ),
    ],

    'Mathematics|Shapes & Geometry': [
      Question(
        type: QuestionType.mcq,
        question: 'How many sides does a pentagon have?',
        options: ['4', '5', '6', '8'],
        correctIndex: 1,
        answer: '5',
        hint: 'Penta = five in Greek.',
        explanation:
            'A pentagon has 5 sides and 5 angles. A regular pentagon has all sides and angles equal. Road signs often use pentagon shape.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'What is the perimeter of a square with side 7 cm?',
        options: ['14 cm', '21 cm', '28 cm', '49 cm'],
        correctIndex: 2,
        answer: '28 cm',
        hint: 'Perimeter of square = 4 × side.',
        explanation:
            'Perimeter = 4 × 7 = 28 cm. For a square, all 4 sides are equal, so we multiply the side by 4.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The perimeter of a rectangle with length 8 cm and breadth 5 cm is ______ cm.',
        answer: '26',
        hint: 'Perimeter = 2 × (length + breadth).',
        explanation:
            'Perimeter = 2 × (8 + 5) = 2 × 13 = 26 cm.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'A circle has no ______, no corners, and only one curved surface.',
        answer: 'Sides',
        hint: 'Polygons have sides, but a circle does not.',
        explanation:
            'A circle is a closed curved figure. Its distance from the centre to any point on its boundary is called the radius.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What is the difference between area and perimeter?',
        answer:
            'Perimeter is the total length of the boundary of a shape (measured in cm, m). Area is the amount of surface covered by a shape (measured in cm², m²). Example: For a rectangle 6 cm × 4 cm, Perimeter = 2×(6+4) = 20 cm, Area = 6×4 = 24 cm².',
        hint: 'Perimeter = boundary, Area = surface inside.',
        explanation:
            'Perimeter uses length units (cm), area uses square units (cm²). Farmers use perimeter for fencing and area for calculating how much crop they can grow.',
      ),
    ],

    // ─────────────────────────────────────────────
    // ENGLISH – GRAMMAR
    // ─────────────────────────────────────────────
    'English|Grammar Basics': [
      Question(
        type: QuestionType.mcq,
        question: 'Which word is a proper noun in: "Priya lives in Mumbai"?',
        options: ['lives', 'in', 'Priya', 'the'],
        correctIndex: 2,
        answer: 'Priya (and Mumbai)',
        hint: 'Proper nouns are names of specific people, places, or things.',
        explanation:
            'Proper nouns are specific names and always start with a capital letter. Priya (name of a person) and Mumbai (name of a city) are proper nouns.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Choose the correct verb: "She ______ to school every day."',
        options: ['go', 'goes', 'gone', 'going'],
        correctIndex: 1,
        answer: 'goes',
        hint: 'She/He/It → add -s or -es to the verb.',
        explanation:
            'With singular subjects (she, he, it), we add -s/-es to the verb in simple present tense. "She goes" is correct.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'Which sentence has correct punctuation?',
        options: [
          'what is your name',
          'What is your name.',
          'What is your name?',
          'what Is your name?',
        ],
        correctIndex: 2,
        answer: 'What is your name?',
        hint: 'Questions end with a question mark, and start with a capital letter.',
        explanation:
            'Interrogative sentences (questions) end with a question mark (?). The first word is always capitalised.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'A word that describes a noun is called an ______.',
        answer: 'Adjective',
        hint: 'It answers: What kind? How many? Which one?',
        explanation:
            'Adjectives modify nouns. e.g. "tall boy", "three apples", "red dress". They make writing more descriptive.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'The plural of "child" is ______.',
        answer: 'Children',
        hint: 'This is an irregular plural (does not follow the normal -s rule).',
        explanation:
            'Irregular plurals don\'t follow the standard rules: child→children, man→men, mouse→mice, tooth→teeth.',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What are the different types of nouns? Give one example of each.',
        answer:
            '1. Common noun – names any person, place, or thing (e.g. city, teacher). 2. Proper noun – names a specific person, place, or thing (e.g. Delhi, Riya). 3. Collective noun – names a group (e.g. a flock of birds, a team of players). 4. Abstract noun – names feelings or ideas that cannot be seen (e.g. happiness, courage).',
        hint: 'There are 4 main types of nouns.',
        explanation:
            'Understanding noun types helps in constructing clear, grammatically correct sentences and improves both written and spoken English.',
      ),
    ],

    'English|Vocabulary': [
      Question(
        type: QuestionType.mcq,
        question: 'What is the synonym of "happy"?',
        options: ['Sad', 'Angry', 'Joyful', 'Tired'],
        correctIndex: 2,
        answer: 'Joyful',
        hint: 'Synonyms have the same or similar meaning.',
        explanation:
            'Synonyms are words with similar meanings. Happy = joyful, cheerful, delighted, pleased. Using synonyms makes writing more interesting.',
      ),
      Question(
        type: QuestionType.mcq,
        question: 'The antonym of "ancient" is:',
        options: ['Old', 'Modern', 'Huge', 'Weak'],
        correctIndex: 1,
        answer: 'Modern',
        hint: 'Antonyms are opposites.',
        explanation:
            'Ancient means very old. Its antonym (opposite) is modern or contemporary.',
      ),
      Question(
        type: QuestionType.fillup,
        question: 'Words that sound the same but have different meanings are called ______.',
        answer: 'Homophones',
        hint: 'Example: "sea" and "see", "their" and "there".',
        explanation:
            'Homophones sound alike but differ in spelling and meaning. e.g. "knight/night", "flour/flower", "here/hear".',
      ),
      Question(
        type: QuestionType.qna,
        question: 'What is the difference between a simile and a metaphor? Give an example of each.',
        answer:
            'A simile compares two things using "like" or "as". Example: "She is as brave as a lion." A metaphor compares two things directly without using "like" or "as". Example: "She is a lion on the battlefield."',
        hint: 'Simile uses "like/as", metaphor does not.',
        explanation:
            'Both are figures of speech used to make comparisons. Similes are more direct and common in everyday language, while metaphors are more powerful and literary.',
      ),
    ],
  };
}
