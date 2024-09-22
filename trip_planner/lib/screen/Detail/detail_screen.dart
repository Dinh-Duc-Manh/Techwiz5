import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../model/Tours.dart';
import '../../model/Users.dart';
import 'Widget/detail_app_bar.dart';
import 'Widget/items_details.dart';
import 'Widget/trip.dart';

class DetailScreen extends StatelessWidget {
  final Users user;
  final Tours tour;

  const DetailScreen({super.key, required this.tour, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      floatingActionButton: Trip(tour: tour, user: user),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailAppBar(tour: tour),
              _buildImageSection(tour.image),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemsDetails(tour: tour),
                    const SizedBox(height: 25),
                    Text(
                      tour.tour_name,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    _buildTourDescription(),
                    const SizedBox(height: 25),
                    _buildTourSchedule(),
                    const SizedBox(height: 25),
                    _buildVisaInfo(),
                    const SizedBox(height: 25),
                    _buildGuideInfo(),
                    const SizedBox(height: 25),
                    _buildPriceDetails(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTourDescription() {
    return Text(
      "Khám phá Thái Lan 5 ngày 4 đêm từ TP.HCM với hành trình qua Bangkok và Pattaya. "
          "Tham quan các điểm nổi bật tại Bangkok như Cung điện Hoàng gia, chùa Phật Ngọc và chùa Bình Minh. "
          "Tiếp tục hành trình đến Pattaya, tham quan Công viên Khủng Long với những màn biểu diễn hấp dẫn. "
          "Thưởng thức ẩm thực Thái Lan phong phú và mua sắm tại các khu chợ đêm nổi tiếng. "
          "Trải nghiệm văn hóa và vẻ đẹp thiên nhiên của Thái Lan qua các điểm đến nổi bật.",
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Widget _buildTourSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Chương trình tour", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20)),
        const SizedBox(height: 10),
        const Text("NGÀY 1: SÀI GÒN - BANGKOK (Ăn Nhẹ, tối)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17)),
        // Add your description for day 1 here...
        const SizedBox(height: 10),
        const Text("NGÀY 2: PATTAYA (ĂN BA BỮA)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17)),
        // Add your description for day 2 here...
      ],
    );
  }

  Widget _buildVisaInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Thông tin Visa", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20)),
        const SizedBox(height: 10),
        const Text("- Quý khách chỉ cần hộ chiếu Việt Nam còn nguyên vẹn và có hạn sử dụng ít nhất 6 tháng tính từ ngày kết thúc tour.", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        const Text("- Miễn visa cho khách mang Quốc Tịch Việt Nam.", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildGuideInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hướng dẫn viên", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20)),
        const SizedBox(height: 10),
        const Text("- Hướng Dẫn Viên (HDV) sẽ liên lạc với Quý Khách khoảng 2-3 ngày trước khi khởi hành.", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildImageSection(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Container(
            height: 200,
            width: double.infinity,
            child: imagePath.startsWith('/data/')
                ? Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            )
                : Image.asset(
              "assets/images/tours/${imagePath}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Chi tiết giá", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20)),
        const SizedBox(height: 10),
        Text("${tour.tour_price} USD", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 100),
      ],
    );
  }
}
