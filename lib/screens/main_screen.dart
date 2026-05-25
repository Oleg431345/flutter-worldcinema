// Главный экран приложения.
// Разделен на вкладки: главное, подборки, коллекции и профиль.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../data/mock_movies.dart';
import '../models/movie.dart';
import '../screens/collections_screen.dart';
import '../screens/profile_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      const _HomeTab(),
      const _PicksTab(),
      const CollectionsScreen(),
      const ProfileScreen(),
    ]);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.fieldBackground,
        selectedItemColor: AppColors.blueAccent,
        unselectedItemColor: AppColors.grayText,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: 'Подборки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Коллекции',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final Movie movie = mockMovies.first;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Captain Marvel', style: AppTextStyles.title),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerPage(videoUrl: movie.videoUrl),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: movie.posterUrl,
                        height: 420,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 420,
                          color: AppColors.fieldBackground,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 420,
                          color: AppColors.fieldBackground,
                          child: const Center(child: Icon(Icons.error, color: AppColors.redAccent)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Фильм дня', style: AppTextStyles.subtitle.copyWith(color: AppColors.grayText)),
                  const SizedBox(height: 8),
                  Text(movie.title, style: AppTextStyles.title),
                  const SizedBox(height: 12),
                  Text(movie.description, style: AppTextStyles.subtitle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PicksTab extends StatelessWidget {
  const _PicksTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Подборки', style: AppTextStyles.title),
              automaticallyImplyLeading: false,
            ),
            const SizedBox(height: 16),
            Text(
              'Выберите подборку фильмов для просмотра.',
              style: AppTextStyles.subtitle.copyWith(color: AppColors.grayText),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: mockMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final movie = mockMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPlayerPage(videoUrl: movie.videoUrl),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.fieldBackground,
                                child: const Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.fieldBackground,
                                child: const Center(child: Icon(Icons.error, color: AppColors.redAccent)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(movie.title, style: AppTextStyles.subtitle.copyWith(color: AppColors.white)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Воспроизведение'),
        backgroundColor: AppColors.fieldBackground,
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: _isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      if (!_controller.value.isPlaying)
                        const Icon(Icons.play_circle_fill, size: 72, color: Colors.white70),
                    ],
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: _isInitialized
          ? FloatingActionButton(
              backgroundColor: AppColors.blueAccent,
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            )
          : null,
    );
  }
}
