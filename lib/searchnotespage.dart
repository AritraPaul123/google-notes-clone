import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/services/db.dart';
import 'model/NoteModel.dart';
import 'noteview.dart';

class SearchNotesView extends StatefulWidget {
  const SearchNotesView({super.key});

  @override
  State<SearchNotesView> createState() => _SearchNotesViewState();
}

class _SearchNotesViewState extends State<SearchNotesView> {
  bool showheader=false;
  List<int> searchresultids = [];
  List<Note?> searchresultnotes = [];

  bool isLoading = true;
  void SearchResults(String query) async {
    searchresultnotes.clear();
    setState(() {
      isLoading = true;
    });
    final resultnotes = await NotesDatabse.instance.SearchResultNote(query);
    resultnotes.forEach((element) async {
      setState(() {
        searchresultnotes.add(element);
      });
    });
    print(searchresultnotes.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: white.withOpacity(0.9),
                        )),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        cursorColor: white,
                        style: TextStyle(
                          fontSize: 16,
                          color: white.withOpacity(0.9),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Search Your Notes",
                          hintStyle: TextStyle(
                              color: white.withOpacity(0.5), fontSize: 16),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            SearchResults(value.toLowerCase());
                            showheader=true;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              isLoading
                  ? SectionAll()
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget SectionAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showheader? Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "SEARCH RESULTS",
                style: TextStyle(
                    color: white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ) : Text(""),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: MasonryGridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchresultnotes.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NoteView(note: searchresultnotes[index])));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: index.isEven
                              ? Colors.green[900]
                              : Colors.blue[900],
                          border: Border.all(
                              color: index.isEven
                                  ? Colors.green.withOpacity(0.4)
                                  : Colors.blue.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(7)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            searchresultnotes[index]!.title,
                            style: TextStyle(
                                color: white.withOpacity(0.9),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            searchresultnotes[index]!.content.length > 200
                                ? "${searchresultnotes[index]!.content.substring(0, 200)}..."
                                : searchresultnotes[index]!.content,
                            style: TextStyle(color: white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                  )),
        )
      ],
    );
  }
}
