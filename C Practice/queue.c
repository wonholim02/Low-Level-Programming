#include <stdio.h>
#include "queue.h"

struct Queue oh_queue;
int push(const char *studentName, const enum subject topicName, const float questionNumber, struct public_key pub_key){
    if (studentName == NULL || questionNumber == -1) {
        return FAILURE;
    } else if (oh_queue.stats.no_of_people_in_queue < MAX_QUEUE_LENGTH) {
        struct Student stu;
        int customID[30] = {0};
        char plaintext[MAX_NAME_LENGTH] = {0};
        int length = 0;

        while (studentName[length] != '\0' && length < MAX_NAME_LENGTH - 1) {
            plaintext[length] = studentName[length];
            length++;
        }
        plaintext[length] = '\0';
        int count = 0;
        while (count < length) {
            stu.customID[count] = customID[count];
            count++;
        }

        hash(stu.customID, plaintext, pub_key);
        length = pub_key.e;
        stu.queue_number = oh_queue.stats.no_of_people_visited + oh_queue.stats.no_of_people_in_queue;
        int i = 0;
        while (studentName[i] != '\0' && i < MAX_NAME_LENGTH - 1) {
            stu.studentData.name[i] = studentName[i];
            i++;
        }

        stu.studentData.name[i] = '\0';
        stu.studentData.topic.topicName = topicName;
        stu.studentData.topic.questionNumber = questionNumber;
        oh_queue.students[oh_queue.stats.no_of_people_in_queue] = stu;
        oh_queue.stats.no_of_people_in_queue++;

        OfficeHoursStatus(&oh_queue.stats);
        return SUCCESS;
    } else {
        return FAILURE;
    }
    return FAILURE;
}

int pop(void) {
    if (oh_queue.stats.no_of_people_in_queue <= 0) {
        return FAILURE;
    }

    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue-1; i++) {
        oh_queue.students[i] = oh_queue.students[i+1];
    }

    oh_queue.stats.no_of_people_in_queue--;

    if (oh_queue.stats.no_of_people_in_queue == 0) {
        oh_queue.stats.currentStatus = "Completed";
    } else {
        oh_queue.stats.currentStatus = "InProgress";
    }

    oh_queue.stats.no_of_people_visited++;

    return SUCCESS;
}

int group_by_topic(struct Topic topic, struct Student *grouped[]) {
    int match = 0;
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (oh_queue.students[i].studentData.topic.topicName == topic.topicName && oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber) {
            grouped[match] = &oh_queue.students[i];
            match++;
        }
    }
    return match;
}

void hash(int *ciphertext, char *plaintext, struct public_key pub_key) {
    int i = 0;
    int x = -1;
    while (plaintext[i] != '\0') {
        x = 1;
        for (int j = 0; j < pub_key.e; j++) {
            x = (x * plaintext[i]) % pub_key.n;
        }
        ciphertext[i] = x;
        i++;
    }
}

int update_student(struct Topic newTopic, int *customID) {
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        int match = 1;

        for (int j = 0; j < MAX_NAME_LENGTH; j++) {
            if (customID[j] != oh_queue.students[i].customID[j] ) {
                match = 0;
                break;
            }
            if (oh_queue.students[i].customID[j] == 0) {
                break;
            }
        }

        if (match) {
            oh_queue.students[i].studentData.topic = newTopic;
            return SUCCESS;
        }

    }
    return FAILURE;
}

int remove_student_by_name(char *name){
    int leng = my_strlen(name);
    int check = 0;
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (my_strncmp(oh_queue.students[i].studentData.name, name, leng) == 0) {
            check = 1;
            for (int j = i; j + 1< oh_queue.stats.no_of_people_in_queue; j++) {
                oh_queue.students[j] = oh_queue.students[j + 1];
            }
            oh_queue.stats.no_of_people_visited++;
            oh_queue.stats.no_of_people_in_queue--;
            break;
        }
    }

    if (check == 1) {
        OfficeHoursStatus(&oh_queue.stats);
        return SUCCESS;
    } else {
        return FAILURE;
    }
}

int remove_student_by_topic(struct Topic topic) {
    int check = 0;
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (oh_queue.students[i].studentData.topic.topicName == topic.topicName && oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber) {
            for (int j = i; j + 1< oh_queue.stats.no_of_people_in_queue; j++) {
                oh_queue.students[j] = oh_queue.students[j + 1];
            }
            oh_queue.stats.no_of_people_visited++;
            oh_queue.stats.no_of_people_in_queue--;
            i--;
            check = 1;
        }
    }

    if (check == 1) {
        OfficeHoursStatus(&oh_queue.stats);
        return SUCCESS;
    } else {
        return FAILURE;
    }
}

void OfficeHoursStatus(struct OfficeHoursStats* resultStats){
    if (resultStats->no_of_people_visited == MAX_QUEUE_LENGTH) {
        resultStats->currentStatus = "Completed";
    } else {
        resultStats->currentStatus = "InProgress";
    }
}

int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) (currNum % n);
}
