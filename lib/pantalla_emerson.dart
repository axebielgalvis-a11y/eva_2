import 'package:flutter/material.dart';

class PantallaEmerson extends StatelessWidget {
  const PantallaEmerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'ARTESANÍA',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CONTENEDOR DE LA IMAGEN DESDE RED ---
            Stack(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  color: const Color(0xFFF3EFE6),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1612196808214-b8e1d6145a8c?q=80&w=1000&auto=format&fit=crop',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF5A4036),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'HECHO A MANO',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // --- DETALLES DEL PRODUCTO ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jarrón de Cerámica\nArtesanal',
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$85.00',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD37B24),
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
                          SizedBox(width: 4),
                          Text(
                            '4.9 ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '(12 reseñas)',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                  const SizedBox(height: 12),

                  const Text(
                    'Este jarrón único ha sido moldeado a mano utilizando técnicas tradicionales de torno. Su acabado texturizado en tonos tierra y crema aporta una sensación orgánica y cálida a cualquier espacio de tu hogar.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildSpecificationRow('Material', 'Barro rojo orgánico'),
                  _buildSpecificationRow('Dimensiones', '25cm x 15cm'),
                  _buildSpecificationRow('Acabado', 'mate natural'),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A4036),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Añadir al carrito',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.black54, fontSize: 14)),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}