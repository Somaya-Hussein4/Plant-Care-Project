import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/shared_widgets/custom_app_text.dart';
import 'package:graduation_project/features/profile/logic/language/language_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/care_guide_cubit.dart';
import '../cubit/care_guide_state.dart';
import '../widgets/article_card.dart';
import '../widgets/care_guide_tab_bar.dart';
import '../widgets/video_card.dart';

class CareGuidePage extends StatelessWidget {
  const CareGuidePage({super.key});

  static String _youtubeThumbnail(String url) {
    final uri = Uri.parse(url);
    String id = '';
    if (uri.host.contains('youtube.com')) {
      id = uri.pathSegments.contains('shorts')
          ? uri.pathSegments.last
          : uri.queryParameters['v'] ?? '';
    } else if (uri.host.contains('youtu.be')) {
      id = uri.pathSegments.first;
    }
    return 'https://img.youtube.com/vi/$id/hqdefault.jpg';
  }

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CareGuideCubit(ctx.read<LanguageCubit>()),
      child: const _CareGuideView(),
    );
  }
}

class _CareGuideView extends StatelessWidget {
  const _CareGuideView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CareGuideCubit>();

    return Scaffold(
      body: BlocListener<CareGuideCubit, CareGuideState>(
        listenWhen: (prev, curr) => prev.articles != curr.articles,
        listener: (ctx, state) {
          for (final article in state.articles) {
            precacheImage(AssetImage(article['img']!), ctx);
          }
        },
        child: Column(
          children: [
            CustomAppText(title: (context) => S.of(context).careGuideTitle),
            BlocBuilder<CareGuideCubit, CareGuideState>(
              buildWhen: (prev, curr) => prev.activeTab != curr.activeTab,
              builder: (_, state) => CareGuideTabBar(
                activeTab: state.activeTab,
                onTabSelected: cubit.selectTab,
              ),
            ),
            Expanded(
              child: BlocBuilder<CareGuideCubit, CareGuideState>(
                builder: (_, state) => state.activeTab == CareGuideTab.articles
                    ? _ArticlesList(articles: state.articles)
                    : _VideosList(videos: state.videos),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticlesList extends StatelessWidget {
  const _ArticlesList({required this.articles});

  final List<Map<String, String>> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      cacheExtent: 500,
      addAutomaticKeepAlives: true,
      itemCount: articles.length,
      itemBuilder: (_, i) => ArticleCard(
        article: articles[i],
        onTap: () => CareGuidePage._launch(articles[i]['url']!),
      ),
    );
  }
}

class _VideosList extends StatelessWidget {
  const _VideosList({required this.videos});

  final List<Map<String, String>> videos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      cacheExtent: 500,
      addAutomaticKeepAlives: true,
      itemCount: videos.length,
      itemBuilder: (_, i) => VideoCard(
        video: videos[i],
        thumbnail: CareGuidePage._youtubeThumbnail(videos[i]['url']!),
        onTap: () => CareGuidePage._launch(videos[i]['url']!),
      ),
    );
  }
}
