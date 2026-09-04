import 'package:flutter/material.dart';

void main() {
  runApp(const DecoracionApp());
}

class DecoracionApp extends StatelessWidget {
  const DecoracionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decoración',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFDFDFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD37A17),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final String image;
  final String name;
  final String price;

  const Product({
    required this.image,
    required this.name,
    required this.price,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    'Todo',
    'Salón',
    'Dormitorio',
    'Cocina',
  ];

  int selectedCategory = 0;
  int selectedBottom = 0;
  int cartCount = 2;

  final Set<int> favorites = {};

  final List<Product> products = const [
    Product(
      image: 'assets/images/jarron.jpg',
      name: 'Jarrón de Cerámica Blanca',
      price: '45,00 €',
    ),
    Product(
      image: 'assets/images/cojin.jpg',
      name: 'Cojín Lino Nude',
      price: '28,50 €',
    ),
    Product(
      image: 'assets/images/lampara.jpg',
      name: 'Lámpara Roble Natural',
      price: '110,00 €',
    ),
    Product(
      image: 'assets/images/espejo.jpg',
      name: 'Espejo Sol Mimbre',
      price: '74,90 €',
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(23, 22, 23, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchRow(),
                    const SizedBox(height: 27),
                    _buildCategories(),
                    const SizedBox(height: 27),
                    _buildProductGrid(),
                  ],
                ),
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF4EF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: TextField(
              controller: searchController,
              cursorColor: const Color(0xFFD37A17),
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5F5A57),
              ),
              decoration: const InputDecoration(
                hintText: 'Buscar decoración...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF77716E),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: Color(0xFF8A9298),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 38,
                  minHeight: 40,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 0,
                  right: 12,
                  top: 11,
                  bottom: 11,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF4EF),
            borderRadius: BorderRadius.circular(13),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              size: 20,
              color: Color(0xFF5D514B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 33,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 13),
        itemBuilder: (context, index) {
          final selected = selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFD67B16)
                    : const Color(0xFFFAF4EF),
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected ? Colors.white : const Color(0xFF5F514A),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 18,

        // IMPORTANTE:
        // Aumentamos la altura disponible para cada tarjeta.
        childAspectRatio: 0.66,
      ),
      itemBuilder: (context, index) {
        return _buildProductCard(index);
      },
    );
  }

  Widget _buildProductCard(int index) {
    final product = products[index];
    final favorite = favorites.contains(index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // IMAGEN
        AspectRatio(
          aspectRatio: 0.82,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox.expand(
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // BOTÓN FAVORITO
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (favorite) {
                        favorites.remove(index);
                      } else {
                        favorites.add(index);
                      }
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.88),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                      size: 19,
                      color: favorite
                          ? const Color(0xFFD67B16)
                          : const Color(0xFF8A8A86),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ESPACIO ENTRE IMAGEN Y NOMBRE
        const SizedBox(height: 7),

        // NOMBRE
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4744),
          ),
        ),

        // ESPACIO ENTRE NOMBRE Y PRECIO
        const SizedBox(height: 3),

        // PRECIO
        Text(
          product.price,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4C4642),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 61,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF1F1F1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(0, Icons.home, 'Inicio'),
          _navItem(1, Icons.search, 'Explorar'),
          _navItem(2, Icons.shopping_bag_outlined, 'Carrito'),
          _navItem(3, Icons.person_outline, 'Perfil'),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final active = selectedBottom == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedBottom = index),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 21,
                  color: active
                      ? const Color(0xFFD37A17)
                      : const Color(0xFF9CA1A4),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active
                        ? const Color(0xFFD37A17)
                        : const Color(0xFF9CA1A4),
                  ),
                ),
              ],
            ),
            if (index == 2 && cartCount > 0)
              Positioned(
                top: 8,
                left: MediaQuery.of(context).size.width / 2 + 1,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD67B16),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$cartCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
