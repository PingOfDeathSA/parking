import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ParkingApp/MyItems.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'Bookings.dart';
import 'BookingsTabs.dart';
import 'Listing.dart';
import 'MappParkingMobile.dart';
import 'MarketPlace.dart';
import 'ResponisveParkingA/AllResponisveParkings.dart';
import 'colors.dart';

class Dashboard extends StatefulWidget {
  late final String user_email;
  Dashboard(this.user_email);

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double text_size;
    double image_size;
    if (width < 768) {
      image_size = 30;
    } else {
      image_size = 70;
    }
    if (width < 768) {
      text_size = 9;
    } else {
      text_size = 10;
    }

    return width > 768
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: color3,
              title: Container(
                margin: new EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                alignment: Alignment.centerLeft,
                height: 40,
                width: image_size * 10,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Parking_A')
                      .where('user_email', isEqualTo: widget.user_email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        return ListTile(
                            title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Welcome ",
                                style: TextStyle(
                                    fontSize: text_size + 3,
                                    color: Colors.white),
                              ),
                              // WidgetSpan(
                              //   child: Icon(Icons.add, size: 14),
                              // ),
                              TextSpan(
                                text: document['user_email'],
                                style: TextStyle(
                                    fontSize: text_size + 3,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ));
                      },
                    );
                  },
                ),
              ),
              flexibleSpace: PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => FirebaseAuth.instance.signOut(),
                            child: Container(
                              height: 25,
                              width: 25,
                              child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/1246/1246273.png"),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () => FirebaseAuth.instance.signOut(),
                              child: Text(
                                "Sign out",
                                style: TextStyle(
                                    fontSize: text_size + 3,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // other widgets here
                    ),
                  ],
                ),
              ),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  controller: sideMenu,
                  style: SideMenuStyle(
                    openSideMenuWidth: 200,
                    backgroundColor: color3,

                    // showTooltip: false,
                    displayMode: SideMenuDisplayMode.auto,
                    hoverColor: color1,
                    selectedColor: color2,
                    unselectedIconColor: color1,

                    selectedTitleTextStyle: TextStyle(color: Colors.white),
                    selectedIconColor: Colors.white,
                    // decoration: BoxDecoration(
                    //   color: color2,
                    //   borderRadius: BorderRadius.all(Radius.circular(50)),
                    // ),
                  ),
                  title: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 150,
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.pexels.com/photos/15360894/pexels-photo-15360894/free-photo-of-woman-standing-on-the-beach.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      // Divider(
                      //   indent: 8.0,
                      //   endIndent: 8.0,
                      // ),
                    ],
                  ),
                  footer: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'SYGE DEVS',
                      style: TextStyle(fontSize: 15, color: color1),
                    ),
                  ),
                  items: [
                    SideMenuItem(
                      priority: 0,
                      title: 'Dashboard',
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: Icon(Icons.home),

                      // tooltipContent: "This is a tooltip for Dashboard item",
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: 'Bookings',
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: Icon(Icons.car_rental),
                    ),
                    SideMenuItem(
                      priority: 2,
                      title: 'Market-Place',
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: Icon(Icons.sell_outlined),
                    ),
                    // SideMenuItem(
                    //   priority: 3,
                    //   title: 'Chats',
                    //   onTap: (page, _) {
                    //     sideMenu.changePage(page);
                    //   },
                    //   icon: const Icon(Icons.chat_bubble),
                    // ),
                    SideMenuItem(
                      priority: 3,
                      title: 'Listing',
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: Icon(Icons.settings),
                    ),
                    SideMenuItem(
                      priority: 4,
                      title: 'My Items',
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: Icon(Icons.shop),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: page,
                    children: [
                      MappedMobileParkings(
                        widget.user_email,
                      ),
                      Taps(
                        widget.user_email,
                      ),
                      MarketPlace(
                        widget.user_email,
                      ),
                      ItemListing(
                        widget.user_email,
                      ),
                      MyItems(
                        widget.user_email,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 60.0,
              items: <Widget>[
                Icon(
                  Icons.local_parking,
                  size: 30,
                  color: SliderRed,
                ),
                Icon(
                  Icons.admin_panel_settings_outlined,
                  size: 30,
                  color: SliderRed,
                ),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: SliderRed,
                ),
                Icon(
                  Icons.upload_outlined,
                  size: 30,
                  color: SliderRed,
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: SliderRed,
                ),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: getCardColor(),
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
              letIndexChange: (index) => true,
            ),
            body: _buildPage(),
          );
  }

  Widget _buildPage() {
    switch (_page) {
      case 0:
        return Center(
          child: MappedMobileParkings(
            widget.user_email,
          ),
        );
      case 1:
        return Center(child: ContainerAdmin(widget.user_email));
      case 2:
        return Center(
          child: MarketPlace(
            widget.user_email,
          ),
        );
      case 3:
        return Center(
          child: ItemListing(
            widget.user_email,
          ),
        );
      case 4:
        return Center(
          child: MyItems(
            widget.user_email,
          ),
        );
      default:
        return Container();
    }
  }
}
