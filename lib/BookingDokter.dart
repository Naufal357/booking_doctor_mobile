import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookPlace extends StatelessWidget {
  const BookPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: size.height * 0.1,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Text(
                              "Booking Dokter",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 24),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://tv-fanatic-res.cloudinary.com/iu/s--KsaMOQ1r--/t_full/cs_srgb,f_auto,fl_strip_profile.lossy,q_auto:420/v1614349785/wanda-maximoff-wandavision-season-1-episode-8.png'),
                      ),
                    ),
                  ],
                ),
                // create center image container
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 200.0,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                //create input name
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50.0,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(        
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50.0,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.date_range),
                          border: InputBorder.none,
                          hintText: "Date",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50.0,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.attach_money),
                          border: InputBorder.none,
                          hintText: "Cost",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // create center submit button
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 25, 27, 193),
                          padding: EdgeInsets.only(
                              left: 80, right: 80, top: 15, bottom: 15)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {}),
                )
              ],
            ),
          )),
    ));
  }
}
