import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../models/idea_model.dart';

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({super.key});

  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _sortBy = 'votes'; // 'votes', 'date'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Улучшенные mock данные
  List<IdeaModel> _allIdeas = [
    IdeaModel(
      id: '1',
      teamId: '1',
      authorId: '1',
      title: 'Добавить датчик расстояния для точной навигации',
      description: 'Использовать ультразвуковой датчик для более точного определения расстояния до объектов. Это позволит улучшить точность позиционирования робота на поле.',
      category: 'Робот',
      status: 'Предложена',
      voterIds: ['1', '2', '3', '4', '5', '6', '7', '8'],
    ),
    IdeaModel(
      id: '2',
      teamId: '1',
      authorId: '2',
      title: 'Оптимизация траектории для автономки',
      description: 'Пересмотреть маршрут автономного режима - использовать диагональные движения для экономии времени. Можем сократить время на 3-4 секунды.',
      category: 'Стратегия',
      status: 'В работе',
      voterIds: ['1', '2', '3', '4', '5', '6'],
    ),
    IdeaModel(
      id: '3',
      teamId: '1',
      authorId: '3',
      title: 'Реализовать систему компьютерного зрения',
      description: 'Добавить OpenCV для распознавания элементов на поле. Это поможет в автономном режиме и улучшит точность захвата.',
      category: 'Программирование',
      status: 'Предложена',
      voterIds: ['1', '2', '3', '4', '5'],
    ),
    IdeaModel(
      id: '4',
      teamId: '1',
      authorId: '1',
      title: 'Улучшить механизм захвата',
      description: 'Заменить резиновые колеса на силиконовые ролики для лучшего захвата элементов. Тесты показали увеличение эффективности на 30%.',
      category: 'Робот',
      status: 'Реализована',
      voterIds: ['1', '2', '3', '4'],
    ),
    IdeaModel(
      id: '5',
      teamId: '1',
      authorId: '2',
      title: 'Создать автоматическую систему логирования',
      description: 'Разработать систему для автоматической записи всех действий робота. Это упростит отладку и анализ проблем.',
      category: 'Программирование',
      status: 'Предложена',
      voterIds: ['1', '2', '3'],
    ),
    IdeaModel(
      id: '6',
      teamId: '1',
      authorId: '3',
      title: 'Провести серию тестов на разных покрытиях',
      description: 'Протестировать робота на разных типах ковров для подготовки к различным условиям соревнований.',
      category: 'Стратегия',
      status: 'Предложена',
      voterIds: ['1', '2'],
    ),
  ];

  List<IdeaModel> get _filteredIdeas {
    List<IdeaModel> ideas;
    
    // Filter by category
    if (_tabController.index == 0) {
      ideas = _allIdeas;
    } else {
      final categories = ['Робот', 'Стратегия', 'Программирование'];
      ideas = _allIdeas.where((idea) => idea.category == categories[_tabController.index - 1]).toList();
    }
    
    // Sort
    if (_sortBy == 'votes') {
      ideas.sort((a, b) => b.voteCount.compareTo(a.voteCount));
    } else {
      ideas.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    
    return ideas;
  }

  void _addNewIdea(String title, String description, String category) {
    setState(() {
      _allIdeas.insert(
        0,
        IdeaModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          teamId: '1',
          authorId: '1',
          title: title,
          description: description,
          category: category,
          status: 'Предложена',
          voterIds: ['1'], // Автор автоматически голосует
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Compact Header with Tabs
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: AppTheme.accentGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.lightbulb,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Идеи',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.sort),
                          onSelected: (value) {
                            setState(() => _sortBy = value);
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'votes',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: _sortBy == 'votes' ? AppTheme.accentColor : null,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('По популярности'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'date',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: _sortBy == 'date' ? AppTheme.accentColor : null,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('По дате'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppTheme.accentColor,
                    unselectedLabelColor: AppTheme.textSecondary,
                    indicatorColor: AppTheme.accentColor,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    onTap: (index) => setState(() {}),
                    tabs: const [
                      Tab(text: 'Все'),
                      Tab(text: 'Робот'),
                      Tab(text: 'Стратегия'),
                      Tab(text: 'Код'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: _filteredIdeas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: AppTheme.accentGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Нет идей',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Предложите первую идею для команды',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredIdeas.length,
                    itemBuilder: (context, index) {
                      return _IdeaCard(
                        idea: _filteredIdeas[index],
                        onVote: () => setState(() {}),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateIdeaBottomSheet(context),
        backgroundColor: AppTheme.accentColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Предложить',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showCreateIdeaBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CreateIdeaBottomSheet(
        onSubmit: (title, description, category) {
          _addNewIdea(title, description, category);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Идея опубликована!'),
              backgroundColor: AppTheme.secondaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
      ),
    );
  }
}

class _IdeaCard extends StatefulWidget {
  final IdeaModel idea;
  final VoidCallback onVote;

  const _IdeaCard({
    required this.idea,
    required this.onVote,
  });

  @override
  State<_IdeaCard> createState() => _IdeaCardState();
}

class _IdeaCardState extends State<_IdeaCard> {
  bool _hasVoted = false;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'В работе':
        return Colors.orange;
      case 'Реализована':
        return AppTheme.secondaryColor;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Робот':
        return Icons.precision_manufacturing;
      case 'Стратегия':
        return Icons.military_tech;
      case 'Программирование':
        return Icons.code;
      case 'Организация':
        return Icons.people;
      default:
        return Icons.lightbulb;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(widget.idea.category),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.idea.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.idea.category,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.idea.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.idea.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(widget.idea.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.idea.description,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(color: Colors.grey.shade200, height: 1),
          
          // Actions
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Vote Button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() => _hasVoted = !_hasVoted);
                      widget.onVote();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: _hasVoted ? AppTheme.accentGradient : null,
                        color: _hasVoted ? null : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _hasVoted ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 18,
                            color: _hasVoted ? Colors.white : AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.idea.voteCount}',
                            style: TextStyle(
                              color: _hasVoted ? Colors.white : AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Comment Button
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline, color: AppTheme.textSecondary),
                  onPressed: () {},
                ),
                
                const Spacer(),
                
                // Share Button
                IconButton(
                  icon: Icon(Icons.share_outlined, color: AppTheme.textSecondary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateIdeaBottomSheet extends StatefulWidget {
  final Function(String title, String description, String category) onSubmit;

  const _CreateIdeaBottomSheet({required this.onSubmit});

  @override
  State<_CreateIdeaBottomSheet> createState() => _CreateIdeaBottomSheetState();
}

class _CreateIdeaBottomSheetState extends State<_CreateIdeaBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = AppConstants.ideaCategories[0];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _titleController.text,
        _descriptionController.text,
        _selectedCategory,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: AppTheme.accentGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.lightbulb,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Предложить идею',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Category Selector
              Text(
                'Категория',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: AppConstants.ideaCategories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: AppTheme.accentColor.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.accentColor : AppTheme.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    checkmarkColor: AppTheme.accentColor,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Название идеи',
                  hintText: 'Кратко опишите вашу идею',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  hintText: 'Расскажите подробнее о вашей идее',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Icon(Icons.description),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppTheme.accentGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentColor.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _handleCreate,
                    borderRadius: BorderRadius.circular(16),
                    child: const Center(
                      child: Text(
                        'Опубликовать идею',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
