import 'package:flutter/material.dart';
import '../../../data/models/note_model/note_model.dart'; // NoteModel modelini ekleyin
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../styles/container_style.dart';

class ViNotesTile extends StatelessWidget {
  const ViNotesTile({
    super.key,
    required this.note,
    this.editOnTap,
  });

  final NoteModel note;
  final Function()? editOnTap;

  @override
  Widget build(BuildContext context) {
    return ViContainer(
      onTap: editOnTap,
      margin: const EdgeInsets.only(bottom: ViSizes.md) +
          const EdgeInsets.symmetric(horizontal: ViSizes.md),
      borderRadius: BorderRadius.circular(ViSizes.cardRadiusLg * 2),
      height: ViHelpersFunctions.screenHeigth(context) * 0.35,
      bgColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(ViSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Not başlığı
            Text(
              note.title, // Notun başlığı
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(height: ViSizes.sm),
            // Not içeriği
            Text(
              note.title, // Notun içeriği
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withValues(alpha: 0.7),
                  ),
              maxLines: 3, // Max 3 satır göster
              overflow: TextOverflow.ellipsis, // Taşan metni üç noktaya çevir
            ),
            const SizedBox(height: ViSizes.md),
            // Diğer not bilgileri (örneğin tarih, etiket, vb.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.createdAt.toString(), // Notun tarihi
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withValues(alpha: 0.5),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
