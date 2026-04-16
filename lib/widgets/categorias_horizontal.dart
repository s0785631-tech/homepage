import 'package:flutter/material.dart';

class CategoriasHorizontal extends StatefulWidget {
  const CategoriasHorizontal({super.key});

  @override
  State<CategoriasHorizontal> createState() => _CategoriasHorizontalState();
}

class _CategoriasHorizontalState extends State<CategoriasHorizontal> {
  late Future<List<_SubCategory>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _loadCategories();
  }

  Future<List<_SubCategory>> _loadCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      const _SubCategory(label: 'Tenis', imageUrl: ''),
      const _SubCategory(label: 'Botas', imageUrl: ''),
      const _SubCategory(label: 'Camisetas', imageUrl: ''),
      const _SubCategory(label: 'Futbol Sports', imageUrl: ''),
      const _SubCategory(label: 'Accesorios', imageUrl: ''),
      const _SubCategory(label: 'Deportivo', imageUrl: ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<_SubCategory>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 108,
            child: Center(
              child: Image.asset(
                'assets/images/Baski_Carga.gif',
                width: 60,
                height: 60,
              ),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox(height: 108);
        }

        final categories = snapshot.data!;
        return SizedBox(
          height: 108,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 18),
            itemBuilder: (context, i) =>
                _SubCategoryItem(item: categories[i]),
          ),
        );
      },
    );
  }
}

class _SubCategoryItem extends StatelessWidget {
  final _SubCategory item;
  const _SubCategoryItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF0EEF6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: item.imageUrl.isEmpty
                  ? const SizedBox()
                  : ClipOval(
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubCategory {
  final String label;
  final String imageUrl;
  const _SubCategory({required this.label, required this.imageUrl});
}
