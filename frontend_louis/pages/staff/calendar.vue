<template>
    <v-row>
        <v-col>
            <v-sheet>
                <v-calendar ref="calendar" :events="events">
                    <template v-slot:event="{ event }">
                        <v-chip @click="handleEventClick(event.id)">
                            {{ formattedDateTime(event.start) }} - {{ event.title }}
                        </v-chip>
                    </template>
                </v-calendar>
            </v-sheet>
        </v-col>
    </v-row>
</template>

<script>
export default {
    data: () => ({
        focus: '',
        events: [],
    }),
    mounted() {
        this.fetchEvents()
    },
    methods: {
        async fetchEvents() {

            this.loading = true;
            const mySelf = this;
            mySelf.events = [];
            await CallApi(`${this.$config.public.apiBaseUrl}/auth/session`, {

            }, async (userinfo) => {
                const { id, permission } = userinfo;
                await CallApi(`${this.$config.public.apiBaseUrl}/staff/schedule`, {
                    id: id
                }, (response) => {
                    const events = [];
                    response.classes.forEach((item) => {
                        events.push({
                            id: item.subject_class_schedule_id,
                            title: item.subject_name,
                            start: mySelf.convertDateToJS(item.lesson_start),
                            end: mySelf.convertDateToJS(item.lesson_end),
                            allDay: false,
                        })
                    });
                    mySelf.events = events;
                    // console.log(mySelf.events)
                }, (error) => {
                    // console.log(error);
                });
            }, (error) => {
                // console.log(error);
            });
            this.loading = false;
        },
        handleEventClick(id) {
            console.log(id);
        },
        formattedDateTime(dateTimeValue) {
            // return dateTimeValue.toString("HH:mm")
            const options = { hour: 'numeric', minute: 'numeric', hour12: true };
            return dateTimeValue.toLocaleTimeString('zh-HK', options);
        },
        convertDateToJS(date) {
            return new Date(date)
        },
    },
}
</script>