import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_jek/model/repo.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:go_jek/utils/clipper.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';

class RepoListItem extends StatelessWidget {
  RepoListItem(this.repo, this.i);

  final Repo repo;
  final int i;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    final TextTheme textTheme = theme.textTheme;

    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        bool isActiveTile = homeProvider.activeTileIndex == i;
        return Container(
          padding: EdgeInsets.only(bottom: isActiveTile ? 2 : 0),
          child: Material(
            elevation: isActiveTile ? 20 : 0,
            color: Colors.white,
            shadowColor: Colors.black12,
            child: Theme(
              data: ThemeData(
                  dividerColor: Colors.transparent,
                  iconTheme:
                      IconThemeData(color: Colors.transparent, opacity: 0)),
              child: ClipRect(
                clipper: RectClipper(),
                clipBehavior: Clip.hardEdge,
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool status) {
                    homeProvider.setActiveTileIndex(isActiveTile ? null : i);
                  },
                  children: [
                    ExpansionPanel(
                      isExpanded: isActiveTile,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) =>
                          ListTile(
                        leading: CircleAvatar(
                          minRadius: 20,
                          maxRadius: 20,
                          backgroundColor: Colors.grey.shade50,
                          backgroundImage: CachedNetworkImageProvider(
                              checkIfNull(repo.avatar)),
                        ),
                        title: AnimatedContainer(
                          duration: Duration(microseconds: 500),
                          height: isExpanded ? 40 : 60,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                checkIfNull(repo.author),
                                style: textTheme.caption,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                checkIfNull(repo.name),
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.title.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(
                            top: 0, right: 16, bottom: 16, left: 16),
                        leading: SizedBox(
                          height: 40,
                          width: 40,
                        ),
                        title: Text(
                          checkIfNull(repo.description),
                          style: textTheme.caption,
                        ),
                        subtitle: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              repo.language == null
                                  ? SizedBox()
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: repo.languageColor != null
                                                ? Pigment.fromString(
                                                    repo.languageColor)
                                                : Colors.blue,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            checkIfNull(repo.language),
                                            style: textTheme.caption
                                                .copyWith(fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                              Image.asset(
                                'assets/icons/star-yellow.png',
                                height: 15,
                                width: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Text(
                                  checkIfNull(repo.stars).toString(),
                                  style:
                                      textTheme.caption.copyWith(fontSize: 10),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'assets/icons/fork-black.png',
                                height: 15,
                                width: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Text(
                                  checkIfNull(repo.forks).toString(),
                                  style:
                                      textTheme.caption.copyWith(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  checkIfNull(data) {
    return data != null ? data : '';
  }
}
