import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:swastha/models/audio_model.dart';
import 'package:swastha/utils/styles.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: Image.network(
                          songList[index].cover,
                          errorBuilder: ((context, error, stackTrace) {
                            return const Icon(Icons.music_note);
                          }),
                        ).image,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${songList[index].title}\n${songList[index].duration}',
                          style: kSubHeadingTextStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          AudioManager.instance
                              .start(
                            songList[index].audioPath,
                            'piano',
                            desc: songList[index].description,
                            auto: true,
                            cover: songList[index].cover,
                          )
                              .then((err) {
                            print(err);
                          });
                        },
                        child: const Icon(
                          Icons.play_circle_outline,
                          size: 48,
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
