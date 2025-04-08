import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _sectionTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const _itemTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const _bidTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  final List<Map<String, dynamic>> _activeAuctions = [
    {
      'title': 'Vintage Watch',
      'price': '\$15,000 starting bid',
      'image': 'lib/assets/images/watch_image.jpeg',
    },
    {
      'title': 'Designer Bag',
      'price': '\$8,000 starting',
      'image': 'lib/assets/images/bag_image.jpg',
    },
    {
      'title': 'Gaming Console',
      'price': '\$500 starting',
      'image': 'lib/assets/images/console_image.jpg',
    },
  ];

  final List<Map<String, dynamic>> _currentAuctions = [
    {
      'title': 'Smartphone',
      'price': 'Current bid: \$500',
      'image': 'lib/assets/images/Smartphone.jpeg',
    },
    {
      'title': 'Construction Toolset',
      'price': 'Current bid: \$300',
      'image': 'lib/assets/images/toolset_image.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAdvertisementPanel(),
                  const SizedBox(height: 20),
                  _buildAuctionSection('Active Auctions', _activeAuctions),
                  const SizedBox(height: 20),
                  _buildAuctionSection('Current Auctions', _currentAuctions),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Handle bid placement
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Place Bid',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Show all labels
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Auctions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Sell Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Horizontal scrollable advertisement banners
  Widget _buildAdvertisementPanel() {
    final bannerImages = [
      'lib/assets/images/advertisement_banner.jpg',
      'lib/assets/images/advertisement_banner2.jpg',
      'lib/assets/images/advertisement_banner3.jpg',
    ];

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: bannerImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              bannerImages[index],
              width: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 300,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image, size: 40)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuctionItem(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 40),
                ),
              ),
            ),  
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: _itemTitleStyle),
                  const SizedBox(height: 4),
                  Text(item['price'], style: _bidTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuctionSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _sectionTitleStyle),
        const SizedBox(height: 8),
        ...items.map((item) => _buildAuctionItem(item)),
      ],
    );
  }
}
