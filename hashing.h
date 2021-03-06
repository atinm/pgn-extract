/*
 *  Program: pgn-extract: a Portable Game Notation (PGN) extractor.
 *  Copyright (C) 1994-2015 David Barnes
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 1, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *  David Barnes may be contacted as D.J.Barnes@kent.ac.uk
 *  http://www.cs.kent.ac.uk/people/staff/djb/
 *
 */

        /* Define a type to hold hash values of interest.
         * This is used both to aid in duplicate detection
         * and in finding positional variations.
         */
typedef struct HashLog {
    /* Store both the final position hash value and
     * the cumulative hash value for a game.
     */
    HashCode final_hash_value;
    HashCode cumulative_hash_value;
    /* Record the file list index for the file this game was first found in. */
    unsigned file_number;
    struct HashLog *next;
} HashLog;

void init_duplicate_hash_table(void);
void clear_duplicate_hash_table(void);
const char *previous_occurance(Game game_details, int plycount);
